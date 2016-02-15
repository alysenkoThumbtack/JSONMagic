//
//  Adventurer.swift
//  JSONMagic
//
//  Created by alysenko on 15/02/16.
//  Copyright © 2016 alysenko. All rights reserved.
//

import Foundation
import ObjectMapper

class Adventurer : Mappable {
    var id: NSInteger!
    var firstName: String!
    var lastName: String?
    var race: String?
    
    var beardColor: UIColor? //optional
    var shoeSize: NSInteger? //optional
    
    //MARK: - Mappable protocol methods
    
    required init?(_ map: Map) {
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        firstName <- map["name"]
        shoeSize <- map["shoe_size"]
    }
}