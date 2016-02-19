//
//  ArgoCategory.swift
//  JSONMagic
//
//  Created by alysenko on 19/02/16.
//  Copyright © 2016 alysenko. All rights reserved.
//

import Foundation

import Argo
import Curry

struct ArgoCategory : Decodable {
    var name: String
    
    static func decode(j: JSON) -> Decoded<ArgoCategory> {
        return curry(ArgoCategory.init)
            <^> j <| "name"
    }
}