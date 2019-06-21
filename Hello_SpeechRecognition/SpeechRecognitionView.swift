//
//  SpeechRecognitionView.swift
//  Hello_SpeechRecognition
//
//  Created by Cyril Garcia on 6/21/19.
//  Copyright © 2019 Cyril Garcia. All rights reserved.
//

import UIKit

class SpeechRecognitionView: UIView {
    
    private let startListeningButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Start Listening", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        return button
    }()
    
    private let stopListeningButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Stop Listening", for: .normal)
        button.setTitleColor(.red, for: .normal)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        addSubview(startListeningButton)
        addSubview(stopListeningButton)
    }
    
}
