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
    typealias ClassifySoeechCompletion = (_ text: String?, _ error: Error?) -> Void
    
    private let audioEngine = AVAudioEngine()
    private let speechRecognizer = SFSpeechRecognizer()
    private let request = SFSpeechAudioBufferRecognitionRequest()
    private var recognitionTask: SFSpeechRecognitionTask?
    
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
        
        recognitionTask = speechRecognizer?.recognitionTask(with: request, resultHandler: { (result, error) in
            
            if let result = result {
                let bestString = result.bestTranscription.formattedString
                completion(bestString, nil)
            } else if let error = error {
                completion(nil, error)
            }
        })
    }
    
    public func finishRecognitionTask() {
        audioEngine.stop()
        request.endAudio()
        recognitionTask?.cancel()
        recognitionTask = nil
    }
    
}
