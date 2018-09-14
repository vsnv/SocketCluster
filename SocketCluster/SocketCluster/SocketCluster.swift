//
//  SocketCluster.swift
//  SocketCluster
//
//  Created by Антон Васнев on 14/09/2018.
//  Copyright © 2018 esk-tek. All rights reserved.
//

import Foundation

public protocol SocketCluster: class {
    init(with: URL, logger: Logger)
    var delegate: SocketClusterDelegate? {get set}
    func connect(completion: (Bool)->Void)
    func emit(event: Event)
}

public protocol SocketClusterDelegate: class {
    func socketClusterSucceededHandshake(socketRocketCluster: SocketCluster)
}

class SocketClusterRealization: SocketCluster {
    
    var logger: Logger
    
    func emit(event: Event) {
       self.logger.info("Emitted event:\n cid: \(event.cid)\n name: \(event.name)\n data: \(event.data)")

    }
    
    required init(with url: URL, logger: Logger) {
        self.logger = logger
        
        self.logger.info("SocketCluster initialized successfully with URL: \(url)")
    }
    
    var delegate: SocketClusterDelegate?
    
    func connect(completion: (Bool)->Void) {
        delegate?.socketClusterSucceededHandshake(socketRocketCluster: self)
        self.logger.info("SocketClusterDelegate: SocketCluster Did Connect")
        
        completion(true)
    }
    
}
