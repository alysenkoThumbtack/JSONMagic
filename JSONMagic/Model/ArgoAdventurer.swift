//
//  ArgoAdventurer.swift
//  JSONMagic
//
//  Created by alysenko on 18/02/16.
//  Copyright © 2016 alysenko. All rights reserved.
//

import Foundation

import Argo
import Curry
import SwiftyJSON

struct ArgoAdventurer : Decodable {
    var id: NSInteger
    var firstName: String
    var lastName: String?
    
    var birthday: NSDate?
    
    var shoeSize: NSInteger?
    var beardColor: UIColor?
    
    //MARK: - Argo.Decodable protocol methods
    
    //TODO: read about complex data types: https://github.com/thoughtbot/Argo/issues/131
    
    static func decode(j: Argo.JSON) -> Decoded<ArgoAdventurer> {
        return curry(ArgoAdventurer.init)
            <^> j <| "id"
            <*> j <| "first_name"
            <*> j <|? "last_name"
            <*> ((j <|? ["memorable_days", "birthday"]) >>- toNSDate)
            <*> j <|? "shoe_size"
            <*> ((j <|? "beard_color") >>- toUIColor)
    }
    
    //MARK: - NSDate parsing methods
    
    private static func toNSDate(dateString: String?) -> Decoded<NSDate?> {
        if let str = dateString {
            return .fromOptional(ArgoAdventurer.jsonDateFormatter().dateFromString(str))
        }
        else {
            return pure(nil)
        }
    }
    
    static func jsonDateFormatter() -> NSDateFormatter {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter
    }
    
    //MARK: - UIColor parsing methods
    
    private static func toUIColor(hexString: String?) -> Decoded<UIColor?> {
        if let str = hexString {
            return .fromOptional(UIColor(hex: str))
        }
        else {
            return pure(nil)
        }
    }
}
