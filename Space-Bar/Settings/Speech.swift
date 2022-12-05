//
//  Speech.swift
//  Space-Bar
//
//  Created by Todd Bruss on 10/25/22.
//  Copyright © 2022 Todd Bruss. All rights reserved.
//

import AVFoundation

func speech(_ text: String) throws {
    #if !targetEnvironment(simulator)
        let utterance = AVSpeechUtterance(string: text)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-GB")
        utterance.volume = 0.45
        synthesizer.speak(utterance)
    #endif
}
