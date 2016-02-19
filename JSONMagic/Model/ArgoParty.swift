//
//  ArgoParty.swift
//  JSONMagic
//
//  Created by alysenko on 19/02/16.
//  Copyright © 2016 alysenko. All rights reserved.
//

import Foundation

import Argo
import Curry

struct ArgoParty : Decodable {
    var adventurers: [ArgoAdventurer]
    
    static func decode(j: JSON) -> Decoded<ArgoParty> {
        return curry(ArgoParty.init)
            <^> j <|| "adventurers"
    }
}