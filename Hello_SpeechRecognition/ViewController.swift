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
    
    private var speechRecognizer: SpeechRecognizerModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        speechRecognizer = SpeechRecognizerModel()
        
        speechRecognizer.requestSpeechAuthorization { (success) in
            print("Good to go")
        }
        
    }
//
//    func speechAuthorization() {
//        SFSpeechRecognizer.requestAuthorization { (auth) in
//            if auth == .authorized {
//                self.startButton.isEnabled = true
//            } else {
//                self.startButton.isEnabled = false
//            }
//        }
//    }
    
    
//    func classifySpeech() {
//        let node = audioEngine.inputNode
//        let recordingFormat = node.outputFormat(forBus: 0)
//
//        node.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer, _) in
//            self.request.append(buffer)
//        }
//
//        audioEngine.prepare()
//        do {
//            try audioEngine.start()
//        } catch {
//            print(error.localizedDescription)
//        }
//
////        guard let myRecognizer = SFSpeechRecognizer() else { return }
//
//        recognitionTask = speechRecognizer?.recognitionTask(with: request, resultHandler: { (result, error) in
//
//            if let result = result {
//                let bestString = result.bestTranscription.formattedString
//                self.detectedTextLabel.text = bestString
//            } else if let error = error {
//                print(error.localizedDescription)
//            }
//        })
//    }
    
    @IBAction func startButtonAction() {
//       classifySpeech()
    }


}

