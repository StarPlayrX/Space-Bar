//
//  SetHighScore.swift
//  Space-Bar
//
//  Created by Todd Bruss on 11/7/22.
//  Copyright © 2022 Todd Bruss. All rights reserved.
//

import Foundation
import SpriteKit
import GameKit


extension GameScene {
    func setHighScore() {
        
//        if gameScore > settings.highscore, GKLocalPlayer.local.isAuthenticated || 1 == 1 {
//            let scoreReporter = GKScore(leaderboardIdentifier: "grp.spaceBarHighScores")
//            scoreReporter.value = Int64(gameScore)
//            let scoreArray: [GKScore] = [scoreReporter]
//
//            GKScore.report(scoreArray, withCompletionHandler: {error -> Void in
//                if error != nil {
//                    print("GAMEKIT:", error as Any)
//                }
//            })
//        }
        
        settings.highscore = gameScore > settings.highscore ? gameScore : settings.highscore
        settings.highlevel = settings.currentlevel > settings.highlevel ? settings.currentlevel : settings.highlevel
    
        if let start = settings.startlevel {
            let lb = LeaderBoard(score: gameScore, playerName: playerName, start: start + 1, stop: settings.currentlevel + 1, date: Date())
            leaderBoard.append(lb)
            AppSettings().saveLeaderBoard()
        }
    }
    
    
   
}




/* grp.spaceBarHighScores
 
 func saveHighscore(gameScore: Int) {

     print("Player has been authenticated.")

     if GKLocalPlayer.localPlayer().authenticated {

         let scoreReporter = GKScore(leaderboardIdentifier: "grp.spaceBarHighScores")
         scoreReporter.value = Int64(gameScore)
         let scoreArray: [GKScore] = [scoreReporter]

         GKScore.reportScores(scoreArray, withCompletionHandler: {error -> Void in
             if error != nil {
                 print("An error has occured: \(error)")
             }
         })
     }
 }
 
 */
