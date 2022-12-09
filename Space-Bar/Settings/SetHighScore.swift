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
    
        if let start = settings.startlevel {
            let lb = LeaderBoard(score: gameScore, playerName: playerName, start: start + 1, stop: settings.currentlevel + 1, date: Date())
            leaderBoard.append(lb)
            AppSettings().saveLeaderBoard()
            
            //MARK: Send Score to the server
            
            DispatchQueue.global(qos: .background).async { [self] in
                sendText(score: gameScore, player: playerName, start: start + 1, stop: settings.currentlevel + 1)
            }
        }
    }
}
