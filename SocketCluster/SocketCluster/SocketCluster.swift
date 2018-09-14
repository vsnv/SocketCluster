//
//  SocketCluster.swift
//  SocketCluster
//
//  Created by Антон Васнев on 14/09/2018.
//  Copyright © 2018 esk-tek. All rights reserved.
//

import Foundation

protocol SocketCluster: class {
    init(with: URL, logger: Logger)
    var delegate: SocketClusterDelegate? {get set}
    func connect()
    func emit(event: Event)
}

protocol SocketClusterDelegate: class {
    func socketClusterSucceededHandshake(socketRocketCluster: SocketCluster)
}

class SocketClusterRealization: SocketCluster {
    
    var logger: Logger
    
    func emit(event: Event) {
        
    }
    
    required init(with url: URL, logger: Logger) {
        self.logger = logger
        
        self.logger.info("SocketCluster initialized successfully with URL: \(url)")
    }
    
    var delegate: SocketClusterDelegate?
    
    func connect() {
        delegate?.socketClusterSucceededHandshake(socketRocketCluster: self)
    }
    
}
