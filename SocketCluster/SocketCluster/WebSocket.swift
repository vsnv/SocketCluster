//
//  WebSocket.swift
//  SocketCluster
//
//  Created by Антон Васнев on 21/09/2018.
//  Copyright © 2018 esk-tek. All rights reserved.
//

import Foundation

public protocol WebSocket {
    init(url: URL)
    func write(data: Data)
//    func write(string: String)
    func open()
//    func disconnect()
//    var onConnect: (() -> Void) {get set}
//    var onData: ((Data) -> Void) {get set}
//    var onDisconnect: ((Error?) -> Void) {get set}
    var delegate: WebSocketDelegate? {get set}
}

public protocol WebSocketDelegate {
    func webSocketDidOpen(_ webSocket: WebSocket)
    func webSocket(_ webSocket: WebSocket, didReceiveMessage: String)
}
