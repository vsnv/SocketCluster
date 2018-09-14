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
    func socketClusterSucceededHandshake(socketRocketCluster: SocketCluster) {
        guard let expectation = asyncExpectation else {
            XCTFail("SpyDelegate was not setup correctly. Missing XCTExpectation reference")
            return
        }
        expectation.fulfill()
    }
    var asyncExpectation: XCTestExpectation?
}
