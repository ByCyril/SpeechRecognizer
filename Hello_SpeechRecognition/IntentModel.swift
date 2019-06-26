//
//  SpeechDecisionModel.swift
//  Hello_SpeechRecognition
//
//  Created by Cyril Garcia on 6/24/19.
//  Copyright © 2019 Cyril Garcia. All rights reserved.
//

import UIKit

class IntentModel {
    
    private var decisionDictionary: [String: Bool]? {
        //Format of the Property List.
        var propertyListForamt =  PropertyListSerialization.PropertyListFormat.xml
        
        //the path of the data
        let plistPath: String? = Bundle.main.path(forResource: "DecisionData", ofType: "plist")!
        
        let plistXML = FileManager.default.contents(atPath: plistPath!)!
        
        //convert the data to a dictionary and handle errors.
        do {
            return try PropertyListSerialization.propertyList(from: plistXML, options: .mutableContainersAndLeaves, format: &propertyListForamt) as? [String:Bool]
        } catch {
            return nil
        }
    }
    
    public func intent(_ text: String?) -> Bool? {
    
//
//        guard let detectedText = detectedText else { return nil }
//        guard let decisionDictionary = self.decisionDictionary else { return nil }
      
        guard let text = text else { return nil }
        let bagOfWords = bow(text: text)
        
        do {
            let prediction = try FeedbackModel().prediction(text: bagOfWords)
            
            return prediction.stars >= 3
        } catch {
            return nil
        }
        
    }
    
    func bow(text: String) -> [String: Double] {
        var bagOfWords = [String: Double]()
        
        let tagger = NSLinguisticTagger(tagSchemes: [.tokenType], options: 0)
        let range = NSRange(location: 0, length: text.utf16.count)
        let options: NSLinguisticTagger.Options = [.omitPunctuation, .omitWhitespace]
        tagger.string = text.lowercased()
        
        tagger.enumerateTags(in: range, unit: .word, scheme: .tokenType, options: options) { _, tokenRange, _ in
            let word = (text as NSString).substring(with: tokenRange)
            if bagOfWords[word] != nil {
                bagOfWords[word]! += 1
            } else {
                bagOfWords[word] = 1
            }
        }
        
        return bagOfWords
    }
    
}
