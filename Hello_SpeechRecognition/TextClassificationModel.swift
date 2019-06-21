//
//  TextClassificationModel.swift
//  Hello_SpeechRecognition
//
//  Created by Cyril Garcia on 6/21/19.
//  Copyright © 2019 Cyril Garcia. All rights reserved.
//

import UIKit

class TextClassificationModel {
    
    private func bow(_ text: String) -> [String: Double] {
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
    
    public func classify(text: String) -> Bool? {
        let textToBow = bow(text)
        
        do {
            let results = try FeedbackModel().prediction(text: textToBow)
            return results.label == 1
        } catch {
            print(error.localizedDescription)
        }
        return nil
    }
}
