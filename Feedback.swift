//
//  Feedback.swift
//  SwingOn
//
//  Created by Jessica Martinez Marquez
//

import Foundation
import AVFoundation

class FeedBack{
    
    func speak(_phrase: String){
        
        let utterance = AVSpeechUtterance(string: _phrase)
        let voice = AVSpeechSynthesisVoice(language: "en-US")
        
        utterance.rate = 0.5
        utterance.volume = 0.8
        utterance.voice = voice
        
        let synthesizer = AVSpeechSynthesizer()
        synthesizer.speak(utterance)
    }
}
