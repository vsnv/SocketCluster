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
    var data:[String: Any] {get}
    var completion: (EventResponse?)->Void {get}
}

class EventRealisation: Event {
    
    var name: String
    
    var cid: String
    
    var data: [String : Any]
    
    var completion: (EventResponse?) -> Void
    
    init(name: String, data: [String : Any], cid: String, completion: @escaping (EventResponse?)->Void) {
        self.name = name
        self.data = data
        self.cid = cid
        self.completion = completion
    }
    
}
