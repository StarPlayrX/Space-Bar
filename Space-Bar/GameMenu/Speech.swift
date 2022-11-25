//
//  Speech.swift
//  Space-Bar
//
//  Created by Todd Bruss on 10/25/22.
//  Copyright © 2022 Todd Bruss. All rights reserved.
//

import AVFoundation

let synthesizer = AVSpeechSynthesizer()            

func speech(_ text: String) throws {
    let utterance = AVSpeechUtterance(string: text)
    //print(AVSpeechSynthesisVoice.speechVoices())
    #if targetEnvironment(macCatalyst)
    utterance.voice = AVSpeechSynthesisVoice(identifier: "com.apple.speech.synthesis.voice.Alex")
    #endif
    #if !targetEnvironment(macCatalyst)
    utterance.voice = AVSpeechSynthesisVoice(identifier: "com.apple.speech.synthesis.voice.daniel.premium")
    #endif
    synthesizer.speak(utterance)
}
