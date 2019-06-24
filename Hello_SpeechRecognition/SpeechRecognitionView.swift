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
    
    private let displayText: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .black
        label.textAlignment = .center
        label.text = "---"
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        backgroundColor = .white
        
        addSubview(startListeningButton)
        addSubview(displayText)
        
        [startListeningButton, displayText].forEach { (element) in
            element.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([startListeningButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
                                     startListeningButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
                                     startListeningButton.heightAnchor.constraint(equalToConstant: 50),
                                     startListeningButton.widthAnchor.constraint(equalToConstant: 150)])
 
        
        NSLayoutConstraint.activate([displayText.centerXAnchor.constraint(equalTo: self.centerXAnchor),
                                     displayText.centerYAnchor.constraint(equalTo: startListeningButton.centerYAnchor, constant: 75),
                                     displayText.heightAnchor.constraint(equalToConstant: 200),
                                     displayText.widthAnchor.constraint(equalToConstant: self.frame.width)])
    }
    
    @objc
    public func enableListenButton(_ bool: Bool) {
        if bool {
            startListeningButton.alpha = 1
        } else {
            startListeningButton.alpha = 0.25
        }
        startListeningButton.isEnabled = bool
    }
    
    @objc
    public func setStartListeningButtonAction(_ selector: Selector, at: UIViewController) {
        startListeningButton.addTarget(at, action: selector, for: .touchUpInside)
    }
    
    @objc
    public func displayText(_ text: String) {
        displayText.text = text
    }
    
}
