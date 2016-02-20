//
//  SearchItem.swift
//  JSONMagic
//
//  Created by alysenko on 16/02/16.
//  Copyright © 2016 alysenko. All rights reserved.
//

import Foundation
import ObjectMapper

import Argo

enum SearchResultsItemType : String, Decodable {
    case Category = "category"
    case Party = "party"
    case Adventurer = "adventurer"
}

class SearchResultsItem : Mappable {
    
    var type: SearchResultsItemType!
    var data: AnyObject!
    
    //MARK: - Mappable protocol methods
    
    required init?(_ map: Map) {
        
    }
    
    func mapping(map: Map) {
        parseType(map)
        parseData(map, type: self.type)
    }
    
    //MARK: -
    
    private func parseType(map: Map) {
        type <- map["type"]
    }
    
    private func parseData(map: Map, type: SearchResultsItemType) {
        let transform = TransformOf(fromJSON: { (json: [String : AnyObject]?) -> AnyObject? in
            if let jsonDict = json {
                switch (type) {
                case .Category:
                    return Mapper<Category>().map(jsonDict)
                case .Adventurer:
                    return Mapper<Adventurer>().map(jsonDict)
                case .Party:
                    return Mapper<Party>().map(jsonDict)
                }
            }
            
            return nil
            
            }) { (object: AnyObject?) -> [String : AnyObject]? in
                if let obj = object {
                    switch (type) {
                    case .Category:
                        return Mapper<Category>().toJSON(obj as! Category)
                    case .Adventurer:
                        return Mapper<Adventurer>().toJSON(obj as! Adventurer)
                    case .Party:
                        return Mapper<Party>().toJSON(obj as! Party)
                    }
                }
                
                return nil
        }
        
        data <- (map["data"], transform)
    }
}