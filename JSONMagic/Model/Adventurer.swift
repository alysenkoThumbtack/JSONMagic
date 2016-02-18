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
    
    var birthday: NSDate?
    
    var beardColor: UIColor?
    var shoeSize: NSInteger?
    
    //MARK: - ObjectMapper.Mappable protocol methods
    
    required init?(_ map: Map) {
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        firstName <- map["first_name"]
        lastName <- map["last_name"]
        
        shoeSize <- map["shoe_size"]
        
        parseBirthday(map)
        parseBeardColor(map)
    }
    
    //MARK: - ObjectMapper parsing methods
    
    private func parseBirthday(map: Map) {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        birthday <- (map["memorable_days.birthday"], DateFormatterTransform(dateFormatter: dateFormatter))
    }
    
    private func parseBeardColor(map: Map) {
        let colorTransform = TransformOf<UIColor, String>(fromJSON: { (value: String?) -> UIColor? in
            if let hex = value {
                return UIColor(hex: hex)
            }
            return nil
            }, toJSON: { (value: UIColor?) -> String? in
                if let color = value {
                    return color.toHexString()
                }
                return nil
        })
        
        beardColor <- (map["beard_color"], colorTransform)
    }
}