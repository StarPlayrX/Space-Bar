//
//  SetHighScore.swift
//  Space-Bar
//
//  Created by Todd Bruss on 11/7/22.
//  Copyright © 2022 Todd Bruss. All rights reserved.
//

import Foundation
import SpriteKit

extension GameScene {
    func setHighScore() {
        settings.highscore = gameScore > settings.highscore ? gameScore : settings.highscore
        settings.highlevel = settings.currentlevel > settings.highlevel ? settings.currentlevel : settings.highlevel
    }
}
