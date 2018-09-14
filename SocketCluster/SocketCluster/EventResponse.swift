//
//  EventResponse.swift
//  SocketCluster
//
//  Created by Антон Васнев on 14/09/2018.
//  Copyright © 2018 esk-tek. All rights reserved.
//

import Foundation

public protocol EventResponse {
    var rid: String? {get}
    var data: [String: Any]? {get}
}
