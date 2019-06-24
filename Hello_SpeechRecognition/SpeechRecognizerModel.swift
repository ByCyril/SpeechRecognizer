//
//  SpeechModel.swift
//  Hello_SpeechRecognition
//
//  Created by Cyril Garcia on 6/20/19.
//  Copyright © 2019 Cyril Garcia. All rights reserved.
//

import UIKit
import Speech

class SpeechRecognizerModel: NSObject, SFSpeechRecognizerDelegate {
    
    typealias RequestSpeechAuthorizationCompletion = (_ success: Bool) -> Void
    typealias ClassifySoeechCompletion = (_ text: String? , _ boolResults: Bool?, _ error: Error?) -> Void
    
    private let audioEngine = AVAudioEngine()
    private let speechRecognizer = SFSpeechRecognizer(locale: Locale.init(identifier: "en_US"))
    private var recognitionTask: SFSpeechRecognitionTask?
    private var request = SFSpeechAudioBufferRecognitionRequest()
    private let speechDecision = SpeechDecisionModel()
    
    public func requestSpeechAuthorization(completion: @escaping RequestSpeechAuthorizationCompletion) {
        SFSpeechRecognizer.requestAuthorization { (authStatus) in
            completion(authStatus == .authorized)
        }
    }
    
    public func classifySpeech(completion: @escaping ClassifySoeechCompletion) {
    
        let node = audioEngine.inputNode
        let recordingFormat = node.outputFormat(forBus: 0)
        
        node.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer, _) in
            self.request.append(buffer)
        }
        
        audioEngine.prepare()

        do {
            try audioEngine.start()
        } catch {
            print(error.localizedDescription)
        }
        
        if #available(iOS 13, *) {
            speechRecognizer?.supportsOnDeviceRecognition = true
            
        } else {
            
        }
        
        if #available(iOS 13, *) {
            request.requiresOnDeviceRecognition = true
        } else {
            // Fallback on earlier versions
        }
//
        recognitionTask = speechRecognizer?.recognitionTask(with: request, resultHandler: { (result, error) in
            
            if let result = result {
                
                let text = result.bestTranscription.formattedString.lowercased()
                let intent = self.speechDecision.intent(text)
                self.stopListening()
                completion(text, intent, nil)
                
                return
            } else if let error = error {
                print("error",error.localizedDescription)
                completion(nil,nil, error)
            }
        
        })
        
        
        
    }
    
    public func stopListening() {
        audioEngine.stop()
        audioEngine.inputNode.removeTap(onBus: 0)
        request.endAudio()
        recognitionTask?.cancel()
        recognitionTask = nil
        
    }
    
}
