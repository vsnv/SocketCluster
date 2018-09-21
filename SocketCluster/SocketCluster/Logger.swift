////
////  Logger.swift
////  SocketCluster
////
////  Created by Антон Васнев on 14/09/2018.
////  Copyright © 2018 esk-tek. All rights reserved.
////
//
//import Foundation
//
//public protocol Logger {
//    func verbose(_ message: Any?, file: String, line: Int, function: String)
//    func debug(_ message: Any?, file: String, line: Int, function: String)
//    func info(_ message: Any?, file: String, line: Int, function: String)
//    func warning(_ message: Any?, file: String, line: Int, function: String)
//    func error(_ message: Any?, file: String, line: Int, function: String)
//}
//
//extension Logger {
//    func verbose(_ message: Any?, file: String = #file, line: Int = #line, function: String = #function) {
//        return verbose(message, file: file, line: line, function: function)
//    }
//    
//    func debug(_ message: Any?, file: String = #file, line: Int = #line, function: String = #function) {
//        return debug(message, file: file, line: line, function: function)
//    }
//
//    func info(_ message: Any?, file: String = #file, line: Int = #line, function: String = #function) {
//        return info(message, file: file, line: line, function: function)
//    }
//    func warning(_ message: Any?, file: String = #file, line: Int = #line, function: String = #function) {
//        return warning(message, file: file, line: line, function: function)
//    }
//    func error(_ message: Any?, file: String = #file, line: Int = #line, function: String = #function) {
//        return error(message, file: file, line: line, function: function)
//    }
//}
