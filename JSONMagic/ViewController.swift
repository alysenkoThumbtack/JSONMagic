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
import SwiftyJSON

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let data = loadJSONdata("hobbits.json") {
            let json = SwiftyJSON.JSON(data: data)
            
            let time = json["since"].stringValue
            print(time)
            if let hobbits = Mapper<Adventurer>().mapArray(json["hobbits"].arrayObject) {
                print(hobbits)
            }
        }
        
        if let data = loadJSONdata("dvarfs.json") {
            let json = SwiftyJSON.JSON(data: data)
            
            let time = json["date"].stringValue
            print(time)
            if let dwarfs: [ArgoAdventurer] = Argo.decode(json["dvarfs"].arrayObject!) {
                print(dwarfs)
            }
        }
        
        //Without SwiftyJSON
        
        if let data = loadJSONdata("hobbits.json") {
            do {
                if let JSONObject = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments) as? [String: AnyObject] {
                    let time = JSONObject["since"] as? String
                    print(time)
                    let hobbitsArray: [AnyObject] = (JSONObject["hobbits"] as! [AnyObject])
                    if let hobbits: [ArgoAdventurer] = Argo.decode(hobbitsArray) {
                        print(hobbits)
                    }
                }
            }
            catch {
                
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadJSONdata(fileName: String) -> NSData? {
        if let JSONString = loadJSON(fileName) {
            return (JSONString as NSString).dataUsingEncoding(NSUTF8StringEncoding)
        }
        return nil
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

