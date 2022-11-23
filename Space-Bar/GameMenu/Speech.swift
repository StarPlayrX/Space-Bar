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
    #if !targetEnvironment(macCatalyst)
        let utterance = AVSpeechUtterance(string: text)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-GB")
        synthesizer.speak(utterance)
    #endif
}
