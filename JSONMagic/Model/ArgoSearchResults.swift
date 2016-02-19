//
//  ArgoSearchResults.swift
//  JSONMagic
//
//  Created by alysenko on 19/02/16.
//  Copyright © 2016 alysenko. All rights reserved.
//

import Foundation

import Argo
import Curry

struct ArgoSearchResults : Decodable {
    
    var items: [ArgoSearchResultsItem]
    
    static func decode(j: JSON) -> Decoded<ArgoSearchResults> {
        return curry(ArgoSearchResults.init)
            <^> j <|| "search_results"
    }
}