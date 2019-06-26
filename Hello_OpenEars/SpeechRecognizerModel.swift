//
//  SpeechRecognizerModel.swift
//  Hello_OpenEars
//
//  Created by Cyril Garcia on 6/26/19.
//  Copyright © 2019 Cyril Garcia. All rights reserved.
//

import UIKit

protocol SpeechRecognizerModelDelegate: AnyObject {
    func intent(_ intent: Bool?, _ recognizedWord: String)
    func didFinishDetectingSpeech()
    
}

class SpeechRecognizerModel: NSObject, OEEventsObserverDelegate {
    private var lmPath: String?
    private var dicPath: String?
    
    private var openEarsEventsObserver = OEEventsObserver()
    
    public var delegate: SpeechRecognizerModelDelegate?
    
    override init() {
        super.init()
        openEarsEventsObserver.delegate = self
    }
    
    public func prepModel(with words: [String]) {
        let lmGenerator = OELanguageModelGenerator()
        let acousticModelPath = OEAcousticModel.path(toModel: "AcousticModelEnglish")
        let name = "FeedbackModel"
        
        let error = lmGenerator.generateLanguageModel(from: words, withFilesNamed: name, forAcousticModelAtPath: acousticModelPath)
        
        if let err = error {
            print(err.localizedDescription)
        } else {
            // Convenience method to reference the path of a language model known to have been created successfully.
            lmPath = lmGenerator.pathToSuccessfullyGeneratedLanguageModel(withRequestedName: name)
            
            // Convenience method to reference the path of a dictionary known to have been created successfully.
            dicPath = lmGenerator.pathToSuccessfullyGeneratedDictionary(withRequestedName: name)
        }
    }
    
    public func startListening() {
        OELogging.startOpenEarsLogging()
        
        try? OEPocketsphinxController.sharedInstance()?.setActive(true)

        let acousticModelPath = OEAcousticModel.path(toModel: "AcousticModelEnglish")

        OEPocketsphinxController.sharedInstance()?.startListeningWithLanguageModel(atPath: lmPath!, dictionaryAtPath: dicPath!, acousticModelAtPath: acousticModelPath, languageModelIsJSGF: false)
    }
    
    public func stopListening() {
        if (OEPocketsphinxController.sharedInstance()!.isListening) {
            OEPocketsphinxController.sharedInstance()?.stopListening()
        }
    }
    
    func pocketsphinxDidReceiveHypothesis(_ hypothesis: String!, recognitionScore: String!, utteranceID: String!) {
        let feedbackTree = ["yes": true, "sure": true, "okay": true, "alright": true, "no": false, "not now": false, "later": false, "no thanks": false]
        
        delegate?.intent(feedbackTree[hypothesis], hypothesis)
    }
    
    func pocketsphinxDidDetectFinishedSpeech() {
        delegate?.didFinishDetectingSpeech()
    }
    
}
