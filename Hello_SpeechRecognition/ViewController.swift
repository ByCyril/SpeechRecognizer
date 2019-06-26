//
//  ViewController.swift
//  Hello_SpeechRecognition
//
//  Created by Cyril Garcia on 6/20/19.
//  Copyright © 2019 Cyril Garcia. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
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
    }
    
    @objc
    public func startListeningAction() {
        
        mainView.enableListenButton(false)
        
        speechRecognizer.requireOnDevice { (success) in
            if !success {
//                not ios 13
            }
        }
        
        speechRecognizer.supportOnDevice { (success) in
            if !success {
//                not ios 13
            }
        }
        
        speechRecognizer.classifySpeech { (text, intent, error) in
            if let text = text {
                self.mainView.displayText(text + "\nIntent: \(intent!)")
            }
            self.mainView.enableListenButton(true)
        }
    }
    
}
