//
//  Party.swift
//  JSONMagic
//
//  Created by alysenko on 16/02/16.
//  Copyright © 2016 alysenko. All rights reserved.
//

import Foundation
import ObjectMapper

class Party: Mappable {
    var adventurers: [Adventurer] = [Adventurer]()
    
    //MARK: - Mappable protocol methods
    
    required init?(_ map: Map) {
        
    }
    
    func mapping(map: Map) {
        adventurers <- map["adventurers"]
    }
}