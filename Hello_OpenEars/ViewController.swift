//
//  ViewController.swift
//  Hello_OpenEars
//
//  Created by Cyril Garcia on 6/26/19.
//  Copyright © 2019 Cyril Garcia. All rights reserved.
//

import UIKit

class ViewController: UIViewController, SpeechRecognizerModelDelegate {
  
    @IBOutlet var intentLabel: UILabel!
    @IBOutlet var recognizedSpeechLabel: UILabel!
    @IBOutlet var startListeningButton: UIButton!
    
    private var speechRecognizerModel = SpeechRecognizerModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        speechRecognizerModel.delegate = self
        speechRecognizerModel.prepModel(with: ["yes","sure","okay","alright","no","not now","no thanks","later"])
    }
    
    @IBAction func startListening() {
        startListeningButton.isHidden = true
        speechRecognizerModel.startListening()
    }
    
    @IBAction func stopListening() {
        speechRecognizerModel.stopListening()
    }
    
    func intent(_ intent: Bool?, _ recognizedWord: String) {
        print("Recognized Word: \(recognizedWord)     Intent: \(intent)")
        intentLabel.text = "\(intent)"
        recognizedSpeechLabel.text = recognizedWord
    }
    
    func didFinishDetectingSpeech() {
        print("Done")
    }
    

}
