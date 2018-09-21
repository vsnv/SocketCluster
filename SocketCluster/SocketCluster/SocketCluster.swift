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
    func emit(event: Event)
}

public protocol SocketClusterDelegate: class {
    func socketClusterSucceededHandshake(socketRocketCluster: SocketCluster)
    func socketClusterFailedHandshake(socketRocketCluster: SocketCluster)
}

class SocketClusterImplementation: SocketCluster {

    var webSocket: WebSocket
    
    func emit(event: Event) {

        let jsonObject: [String: Any] = [
            "event": event.name,
            "data": event.data,
            "cid": event.cid
        ]
        
        let valid = JSONSerialization.isValidJSONObject(jsonObject)

        let jsonData = try! JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted)

        webSocket.write(data: jsonData)

    }
    
    required init(with webSocket: WebSocket) {
        self.webSocket = webSocket
        self.webSocket.delegate = self
    }
    
    var delegate: SocketClusterDelegate?
    
    private var lastHandshakeCid = UUID()
    
    func connect() {
        
        webSocket.open()

    }
    
}

extension SocketClusterImplementation: WebSocketDelegate {
    
    func webSocket(_ webSocket: WebSocket, didReceiveMessage message: String) {
        if let dict = getDict(from: message), let rid = dict["rid"] as? String, rid == self.lastHandshakeCid.uuidString {
            
            delegate?.socketClusterSucceededHandshake(socketRocketCluster: self)
            
            
        } else {
            
        }
    }
    
    
    func webSocketDidOpen(_ webSocket: WebSocket) {
        sendHandshake()
    }
    
    
}

extension SocketClusterImplementation {
    private func sendHandshake() {
        
        self.lastHandshakeCid = UUID()
        
        let event: Event = EventImplementation(name: "#handshake", data: [:], cid: self.lastHandshakeCid.uuidString)
        
        emit(event: event)
        
        
    }
    
    private func getDict(from message: String) -> [String: Any]? {
        
        if let data = message.data(using: String.Encoding.utf8), let json = try? JSONSerialization.jsonObject(with: data, options: []), let dict = json as? [String: Any] {

            return dict
            
        } else {
            return nil
        }
    }
}
