//
//  ViewController.swift
//  Hello_SpeechRecognition
//
//  Created by Cyril Garcia on 6/20/19.
//  Copyright © 2019 Cyril Garcia. All rights reserved.
//

import UIKit
import Speech

class ViewController: UIViewController, SFSpeechRecognizerDelegate {
    
    private var speechRecognizer: SpeechRecognizerModel!
    private var mainView: SpeechRecognitionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        speechRecognizer = SpeechRecognizerModel()
        speechRecognizer.requestSpeechAuthorization { (success) in
            print(success)
        }
        
        mainView = SpeechRecognitionView(frame: view.bounds)
        view.addSubview(mainView)
        
        mainView.setStartListeningButtonAction(#selector(ViewController.startListeningAction), at: self)
        mainView.setStopListeningButtonAction(#selector(ViewController.stopListeningAction), at: self)
    }
    
    @objc
    public func startListeningAction() {
        speechRecognizer.classifySpeech { (results, error) in
            if let results = results {
                self.mainView.displayText(results)
            }
        }
    }
    
    @objc
    public func stopListeningAction() {
        speechRecognizer.stopListening()
    }

}
