//
//  SpeechDecisionModel.swift
//  Hello_SpeechRecognition
//
//  Created by Cyril Garcia on 6/24/19.
//  Copyright © 2019 Cyril Garcia. All rights reserved.
//

import UIKit

class SpeechDecisionModel {
    private var decisionDictionary: [String: Bool]? {
        //Format of the Property List.
        var propertyListForamt =  PropertyListSerialization.PropertyListFormat.xml
        let plistPath: String? = Bundle.main.path(forResource: "DecisionData", ofType: "plist")! //the path of the data
        let plistXML = FileManager.default.contents(atPath: plistPath!)!
        
        do {//convert the data to a dictionary and handle errors.
            return try PropertyListSerialization.propertyList(from: plistXML, options: .mutableContainersAndLeaves, format: &propertyListForamt) as? [String:Bool]
        } catch {
            return nil
        }
    }
    
    public func intent(_ detectedText: String?) -> Bool? {
    
        guard let detectedText = detectedText else { return nil }
        guard let decisionDictionary = self.decisionDictionary else { return nil }
        
        return decisionDictionary[detectedText]
    }
    
}
