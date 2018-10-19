//
//  MockSocketClusterDelegate.swift
//  SocketClusterTests
//
//  Created by Антон Васнев on 14/09/2018.
//  Copyright © 2018 esk-tek. All rights reserved.
//

import Foundation
import XCTest
import SocketCluster

class MockSocketClusterDelegate {
    
    var didConnectExpectation: XCTestExpectation?
    var didReceivePingExpectation: XCTestExpectation?
    var socketClusterSucceededHandshakeExpectation: XCTestExpectation?
    var socketClusterFailedHandshakeExpectation: XCTestExpectation?
    
}

extension MockSocketClusterDelegate: SocketClusterDelegate {
    
    func socketClusterDidReceivePing(_ socketCluster: SocketCluster) {
        guard let didReceivePingExpectation = didReceivePingExpectation else {
            XCTFail("MockSocketClusterDelegate was not setup correctly. Missing XCTExpectation reference")
            return
        }
        didReceivePingExpectation.fulfill()
    }
    
    
    func socketClusterSucceededHandshake(_ socketCluster: SocketCluster) {
        guard let socketClusterSucceededHandshakeExpectation = socketClusterSucceededHandshakeExpectation else {
            XCTFail("MockSocketClusterDelegate was not setup correctly. Missing XCTExpectation reference")
            return
        }
        socketClusterSucceededHandshakeExpectation.fulfill()
    }
    
    
    func socketClusterDidConnect(_ socketCluster: SocketCluster) {
        guard let didConnectExpectation = didConnectExpectation else {
            XCTFail("MockSocketClusterDelegate was not setup correctly. Missing XCTExpectation reference")
            return
        }
        didConnectExpectation.fulfill()
        
        socketCluster.sendHandshake()
    }
    
    func socketClusterFailedHandshake(_ socketRocketCluster: SocketCluster) {
        guard let socketClusterFailedHandshakeExpectation = socketClusterFailedHandshakeExpectation else {
            XCTFail("MockSocketClusterDelegate was not setup correctly. Missing XCTExpectation reference")
            return
        }
        socketClusterFailedHandshakeExpectation.fulfill()
    }
}
