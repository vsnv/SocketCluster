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

class MockSocketClusterDelegate: SocketClusterDelegate {
    func socketClusterFailedHandshake(socketRocketCluster: SocketCluster) {
        guard let failExpectation = failExpectation else {
            XCTFail("SpyDelegate was not setup correctly. Missing XCTExpectation reference")
            return
        }
        failExpectation.fulfill()
    }
    
    func socketClusterSucceededHandshake(socketRocketCluster: SocketCluster) {
        guard let successExpectation = successExpectation else {
            XCTFail("SpyDelegate was not setup correctly. Missing XCTExpectation reference")
            return
        }
        successExpectation.fulfill()
    }
    var successExpectation: XCTestExpectation?
    var failExpectation: XCTestExpectation?
}
