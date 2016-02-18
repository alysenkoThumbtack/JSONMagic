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

class DecodableDateWrapper : Decodable {
    var date: NSDate
    
    init(date: NSDate) {
        self.date = date
    }
    
    static func decode(j: JSON) -> Decoded<DecodableDateWrapper> {
        switch j {
        case let .String(s):
            if let date = jsonDateFormatter().dateFromString(s) {
                let wrapper = DecodableDateWrapper(date: date)
                return pure(wrapper)
            }
            else {
                return .Failure(DecodeError.Custom("Incorrect date format"))
            }
            
        default: return .Failure(DecodeError.Custom("Incorrect date format"))
        }
    }
    
    static func jsonDateFormatter() -> NSDateFormatter {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter
    }
}

struct ArgoAdventurer : Decodable {
    var id: NSInteger
    var firstName: String
    var lastName: String?
    
    var birthday: DecodableDateWrapper?
    var shoeSize: NSInteger?
    
    //MARK: - Argo.Decodable protocol methods
    
    static func decode(j: JSON) -> Decoded<ArgoAdventurer> {
        return curry(ArgoAdventurer.init)
            <^> j <| "id"
            <*> j <| "first_name"
            <*> j <|? "last_name"
            <*> j <|? ["memorable_days", "birthday"]
            <*> j <|? "shoe_size"
    }
}
