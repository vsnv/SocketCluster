//
//  SocketCluster.swift
//  SocketCluster
//
//  Created by Антон Васнев on 14/09/2018.
//  Copyright © 2018 esk-tek. All rights reserved.
//

import Foundation

public protocol SocketCluster: class {
    init(with webSocket: WebSocket)
    var delegate: SocketClusterDelegate? {get set}
    func connect()
    func emit(_: Event)
    func sendHandshake()
}

public protocol SocketClusterDelegate: class {
    func socketClusterDidConnect(_ socketCluster: SocketCluster)
    func socketClusterDidReceivePing(_ socketCluster: SocketCluster)
    func socketClusterSucceededHandshake(_ socketCluster: SocketCluster)
    func socketClusterFailedHandshake(_ socketCluster: SocketCluster)
}

class SocketClusterImplementation: SocketCluster {

    var webSocket: WebSocket

    
    required init(with webSocket: WebSocket) {
        self.webSocket = webSocket
        self.webSocket.delegate = self
    }
    
    var delegate: SocketClusterDelegate?
    
    private var lastHandshakeCid = UUID()
    
    func connect() {
        
        webSocket.open()

    }
    
    func sendHandshake() {
        
        self.lastHandshakeCid = UUID()
        
        let event: Event = EventImplementation(name: "#handshake", data: [:], cid: self.lastHandshakeCid.uuidString)
        
        emit(event)
        
        
    }
    
    
    func emit(_ event: Event) {
        
        let jsonObject: [String: Any] = [
            "event": event.name,
            "data": event.data,
            "cid": event.cid
        ]
        
        let valid = JSONSerialization.isValidJSONObject(jsonObject)
        
        let jsonData = try! JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted)
        
        webSocket.write(data: jsonData)
        
    }
    
}

extension SocketClusterImplementation: WebSocketDelegate {
    
    func webSocket(_ webSocket: WebSocket, didReceiveMessage message: String) {
        
        if message.lowercased() == "#1" {
            
            delegate?.socketClusterDidReceivePing(self)
            
        } else if let dict = getDict(from: message), let rid = dict["rid"] as? String, rid == self.lastHandshakeCid.uuidString {

            delegate?.socketClusterSucceededHandshake(self)


        } else {
            

        }
    }
    
    
    func webSocketDidOpen(_ webSocket: WebSocket) {
//        sendHandshake()
        delegate?.socketClusterDidConnect(self)
    }
    
    
}

extension SocketClusterImplementation {

    
    private func getDict(from message: String) -> [String: Any]? {
        
        if let data = message.data(using: String.Encoding.utf8), let json = try? JSONSerialization.jsonObject(with: data, options: []), let dict = json as? [String: Any] {

            return dict
            
        } else {
            return nil
        }
    }
}
