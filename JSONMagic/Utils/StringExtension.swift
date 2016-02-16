//
//  Ext.swift
//  RSBarcodesSample
//
//  Created by R0CKSTAR on 6/10/14.
//  Copyright (c) 2014 P.D.Q. All rights reserved.
//

import UIKit

extension String {
    
    static func stringByCFString(string: CFString) -> String {
        return string as String
    }
    
    static func nonNullText(text: String?) -> String {
        if text == nil {
            return ""
        }
        
        return text!
    }
    
    func length() -> Int {
        return self.characters.count
    }
    
    func trim() -> String {
        return self.stringByTrimmingCharactersInSet(.whitespaceAndNewlineCharacterSet())
    }
    
    func substring(location:Int, length:Int) -> String! {
        return (self as NSString).substringWithRange(NSMakeRange(location, length))
    }
    
    subscript(index: Int) -> String! {
        get {
            return self.substring(index, length: 1)
        }
    }
    
    func location(other: String) -> Int {
        return (self as NSString).rangeOfString(other).location
    }
    
    func contains(other: String) -> Bool {
        return (self as NSString).containsString(other)
    }
    
    // http://stackoverflow.com/questions/6644004/how-to-check-if-nsstring-is-contains-a-numeric-value
    func isNumeric() -> Bool {
        return (self as NSString).rangeOfCharacterFromSet(NSCharacterSet.decimalDigitCharacterSet().invertedSet).location == Foundation.NSNotFound
    }
    
    
    // next chunk up through pluralize was adapted from:
    // https://gist.github.com/albertbori/0faf7de867d96eb83591
    func subString(startIndex: Int, length: Int) -> String {
        let start = self.startIndex.advancedBy(startIndex)
        let end = self.startIndex.advancedBy(startIndex + length)
        return self.substringWithRange(Range<String.Index>(start: start, end: end))
    }
    
    private var vowels: [String] {
        get {
            return ["a", "e", "i", "o", "u"]
        }
    }
    
    private var consonants: [String] {
        get {
            return ["b", "c", "d", "f", "g", "h", "j", "k", "l", "m", "n", "p", "q", "r", "s", "t", "v", "w", "x", "z"]
        }
    }
    
    subscript (r: Range<Int>) -> String {
        get {
            let startIndex = self.startIndex.advancedBy(r.startIndex)
            let endIndex = self.startIndex.advancedBy(r.endIndex - 1)
            
            return self[Range(start: startIndex, end: endIndex)]
        }
    }
    
    func pluralize(count: Int) -> String {
        if count == 1 {
            return self
        } else {
            let lastChar = self.subString(self.length() - 1, length: 1)
            let secondToLastChar = self.subString(self.length() - 2, length: 1)
            var prefix = "", suffix = ""
            
            if lastChar.lowercaseString == "y" && vowels.filter({x in x == secondToLastChar}).count == 0 {
                prefix = self[0...self.length() - 1]
                suffix = "ies"
            } else if lastChar.lowercaseString == "s" || (lastChar.lowercaseString == "o" && consonants.filter({x in x == secondToLastChar}).count > 0) {
                prefix = self[0...self.length()]
                suffix = "es"
            } else {
                prefix = self[0...self.length()]
                suffix = "s"
            }
            
            return prefix + (lastChar != lastChar.uppercaseString ? suffix : suffix.uppercaseString)
        }
    }
    
    func stringByAppendingString(string: String, withSeparator separator: String) -> String {
        if string == "" {
            return "\(self)"
        }
        let stringToAppend = (self == "") ? string : separator + string
        return stringByAppendingString(stringToAppend)
    }
    
    func URLStringByAppendingPathComponent(component: String) -> String {
        let url = NSURL(string: self)
        return url!.URLByAppendingPathComponent(component).path!
    }
    
    func URLPathComponents() -> [String]? {
        let url = NSURL(string: self)
        return url!.pathComponents
    }
}