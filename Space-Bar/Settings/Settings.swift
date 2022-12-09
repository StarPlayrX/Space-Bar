//
//  Settings.swift
//  Space-Bar
//
//  Created by Todd Bruss on 11/5/22.
//  Copyright © 2022 Todd Bruss. All rights reserved.
//

import Foundation

struct Settings: Codable {
    var puck        : Int  =  0
    var level       : Int  =  0
    var startlevel  : Int? =  nil
    var currentlevel: Int  =  0
    var highlevel   : Int  =  1
    var score       : Int  =  0
    var highscore   : Int  =  0
    var lives       : Int  =  3
    var sound       : Bool =  true
    var height      : CGFloat? = nil
}

struct AppSettings {
    let spaceBarGameSettings = "SpaceBarGameSettingsX1"
    let spaceBarLeaderBoardTop20 = "SpaceBarGameLeaderBoardTop20"
    
    func saveUserDefaults() {
        UserDefaults.standard.set(try? PropertyListEncoder().encode(settings), forKey:spaceBarGameSettings)
    }
    
    func loadUserDefaults() {
        if let data = UserDefaults.standard.value(forKey:spaceBarGameSettings) as? Data,
           let disk = try? PropertyListDecoder().decode(Settings.self, from: data) {
            settings = disk
        }
    }
    
    func leaderRunDown() {
        addBasicLeaderBoard()
        sortLeaderBoard()
        trimLeaderBoard()
    }
    
    //MARK: Sort Leaderboard
    func sortLeaderBoard() {
        leaderBoard.sort(by: {($1.score, $1.stop, $0.start) < ($0.score, $0.stop, $1.start)})
    }
    
    //MARK: Trim Leaderboard
    func trimLeaderBoard() {
        if leaderBoard.count > 20 {
            leaderBoard = Array(leaderBoard[0..<20])
        }
    }
    
    //MARK: Create a Basic Leaderboard
    func addBasicLeaderBoard() {
        if leaderBoard.count < 20 {
            for i in 1...20 {
                let lb = LeaderBoard(score: i, playerName: "StarPlayerX \(i)", start: 1, stop: 1, date: Date())
                leaderBoard.append(lb)
            }
        }
    }
    
    //MARK: Save Leaderboard
    func saveLeaderBoard() {
        leaderRunDown()
        UserDefaults.standard.set(try? PropertyListEncoder().encode(leaderBoard), forKey:spaceBarLeaderBoardTop20)
    }
    
    //MARK: Load Leaderboard
    func loadLeaderboard() {
        if let data = UserDefaults.standard.value(forKey:spaceBarLeaderBoardTop20) as? Data,
           let lb = try? PropertyListDecoder().decode([LeaderBoard].self, from: data) {
            leaderBoard = lb
            leaderRunDown()
        } else {
            leaderRunDown()
        }
        
        DispatchQueue.global(qos:.background).async {
            getData()
        }
    }
}

