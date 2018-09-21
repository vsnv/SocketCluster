//
//  Event.swift
//  SocketCluster
//
//  Created by Антон Васнев on 14/09/2018.
//  Copyright © 2018 esk-tek. All rights reserved.
//

import Foundation

public protocol Event {
    var name: String {get}
    var cid: String {get}
    var data: [String: Any] {get}
}

class EventImplementation: Event {
    
    var name: String
    
    var cid: String
    
    var data: [String: Any]

    init(name: String, data: [String:Any], cid: String) {
        self.name = name
        self.data = data
        self.cid = cid
    }
    
}
