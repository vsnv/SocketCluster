//
//  MockWebSocket.swift
//  SocketClusterTests
//
//  Created by Антон Васнев on 21/09/2018.
//  Copyright © 2018 esk-tek. All rights reserved.
//

import Foundation
import XCTest
import SocketCluster

class MockWebSocket: WebSocket {
    
    static let rightConnectionStringStub = URL(string: "wss://socketclusterstub:443/socketcluster/")!
    static let wrongConnectionStringStub = URL(string: "wss://FAILsocketclusterstub:443/socketcluster/")!
    
    var url: URL
    
    required init(url: URL) {
        self.url = url
    }
    

    func write(data: Data) {
        
        if let json = try? JSONSerialization.jsonObject(with: data, options: []) {
            if let dict = json as? [String: Any] {
                if let eventName = dict["event"] as? String {
                    if eventName == "#handshake" {
                        
                        let jsonObject: [String: Any] = [
                            "rid": dict["cid"],
                            "data": [
                                "id": "fuYzY0yLwcIXhKNhAAPn",
                                "pingTimeout": 20000,
                                "isAuthenticated": false
                            ]
                        ]
                        
                        let jsonData = try! JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted)
                        
                        let string = String.init(data: jsonData, encoding: String.Encoding.utf8)!

                        delegate?.webSocket(self, didReceiveMessage: string)
                    }
                }
            }
        }

    }
    
    func open() {
        
        if self.url == MockWebSocket.rightConnectionStringStub {
            
            delegate?.webSocketDidOpen(self)
            
        } else {
            
            delegate?.webSocketDidOpen(self)
            
        }
        
        
    }
    
    var delegate: WebSocketDelegate?
    
    
}
