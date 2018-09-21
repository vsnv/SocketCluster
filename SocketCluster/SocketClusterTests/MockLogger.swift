//
//  MockLogger.swift
//  SocketClusterTests
//
//  Created by Антон Васнев on 14/09/2018.
//  Copyright © 2018 esk-tek. All rights reserved.
//

//import Foundation
//import XCTest
//import SocketCluster
//
//class MockLogger: Logger {
//    
//    var verboseExpectation: XCTestExpectation?
//    var debugExpectation: XCTestExpectation?
//    var infoExpectation: XCTestExpectation?
//    var warningExpectation: XCTestExpectation?
//    var errorExpectation: XCTestExpectation?
//    
//    func verbose(_ message: Any?, file: String, line: Int, function: String) {
//        verboseExpectation?.fulfill()
//    }
//    
//    func debug(_ message: Any?, file: String, line: Int, function: String) {
//        debugExpectation?.fulfill()
//    }
//    
//    func info(_ message: Any?, file: String, line: Int, function: String) {
//        guard let expectation = infoExpectation else { return }
//        
//        if let string = message as? String, expectation.description == string {
//            expectation.fulfill()
//        }
//    }
//    
//    func warning(_ message: Any?, file: String, line: Int, function: String) {
//        warningExpectation?.fulfill()
//    }
//    
//    func error(_ message: Any?, file: String, line: Int, function: String) {
//        errorExpectation?.fulfill()
//    }
//    
//    
//}
