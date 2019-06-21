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
    
    @IBOutlet var detectedTextLabel: UILabel!
    @IBOutlet var startListingButton: UIButton!
    
    private var speechRecognizer: SpeechRecognizerModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        speechRecognizer = SpeechRecognizerModel()
        
        speechRecognizer.requestSpeechAuthorization { (success) in
            print(success)
        }
        
    }
    
    @IBAction func startListening() {
        speechRecognizer.classifySpeech { (text, error) in
            if let text = text {
                self.detectedTextLabel.text = text
            }
        }
    }
    
    @IBAction func stopListening() {
        speechRecognizer.finishRecognitionTask()
    }

}
