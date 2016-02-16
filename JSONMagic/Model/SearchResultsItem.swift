//
//  SearchItem.swift
//  JSONMagic
//
//  Created by alysenko on 16/02/16.
//  Copyright © 2016 alysenko. All rights reserved.
//

import Foundation
import ObjectMapper

enum SearchResultsItemType : String {
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
        let typeTransform = TransformOf<SearchResultsItemType, String>(fromJSON: { (value: String?) -> SearchResultsItemType? in
            if let string = value {
                return SearchResultsItemType(rawValue: string)
            }
            return nil
            }, toJSON: { (value: SearchResultsItemType?) -> String? in
                return value?.rawValue
        })
        
        type <- (map["type"], typeTransform)
    }
    
    private func parseData(map: Map, type: SearchResultsItemType) {
        let jsonDict = map["data"].currentValue
        switch (type) {
        case .Category:
            data = Mapper<Category>().map(jsonDict)
        case .Adventurer:
            data = Mapper<Adventurer>().map(jsonDict)
        case .Party:
            data = Mapper<Party>().map(jsonDict)
        }
    }
}