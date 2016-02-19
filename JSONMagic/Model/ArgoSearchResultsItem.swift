//
//  ArgoSearchResultsItem.swift
//  JSONMagic
//
//  Created by alysenko on 19/02/16.
//  Copyright © 2016 alysenko. All rights reserved.
//

import Foundation

import Argo
import Curry

struct ArgoSearchResultsItem : Decodable {
    
    var type: SearchResultsItemType
    var data: Any
    
    static func decode(j: JSON) -> Decoded<ArgoSearchResultsItem> {
        
        let type: SearchResultsItemType = (j <| "type")!
        
        var data: Any
        switch (type) {
        case .Adventurer:
            let adventurer: ArgoAdventurer = (j <| "data")!
            data = adventurer 
            break
        case .Category:
            let category: ArgoCategory = (j <| "data")!
            data = category
            break
        case .Party:
            let party: ArgoParty = (j <| "data")!
            data = party
            break
        }
        
        let item = ArgoSearchResultsItem(type: type, data: data)
        
        return pure(item)
    }
}