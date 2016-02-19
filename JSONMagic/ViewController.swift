////
//  ViewController.swift
//  JSONMagic
//
//  Created by alysenko on 15/02/16.
//  Copyright © 2016 alysenko. All rights reserved.
//

import UIKit

import ObjectMapper
import Argo

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let JSONString = loadJSON("party.json") {
            if let party = Mapper<Party>().map(JSONString) {
                print(party)
            }
        }
        
        if let JSONString = loadJSON("search.json") {
            let searchResults = Mapper<SearchResults>().map(JSONString)
            print(searchResults)
        }
        
        if let JSONString = loadJSON("adventurer.json") {
            if let data = (JSONString as NSString).dataUsingEncoding(NSUTF8StringEncoding) {
                let json: AnyObject? = try? NSJSONSerialization.JSONObjectWithData(data, options: [])
                if let j: AnyObject = json {
                    let adventurer: ArgoAdventurer? = decode(j)
                    print(adventurer)
                }
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadJSON(fileName: String) -> String? {
        var json: String? = nil
        if let filePath = NSBundle.mainBundle().pathForResource(fileName, ofType: nil) {
            do {
                json = try String(contentsOfFile: filePath, encoding: NSUTF8StringEncoding)
            }
            catch {
                // handle error
            }
        }
        
        return json
    }
}

