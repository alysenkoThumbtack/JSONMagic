//
//  SearchResults.swift
//  JSONMagic
//
//  Created by alysenko on 16/02/16.
//  Copyright © 2016 alysenko. All rights reserved.
//

import Foundation
import ObjectMapper

class SearchResults: Mappable {
    var items : [SearchResultsItem]!
    
    required init?(_ map: Map) {
        
    }
    
    func mapping(map: Map) {
        items <- map["search_results"]
    }
}