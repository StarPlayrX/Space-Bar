//
//  Settings.swift
//  Space-Bar
//
//  Created by Todd Bruss on 8/29/21.
//  Copyright © 2021 Todd Bruss. All rights reserved.
//

import Foundation

struct Settings: Codable {
    var puck: Int          =  0
    var level: Int         =  0
    var currentlevel: Int  =  0
    var maxlevel: Int      =  71
    var highlevel: Int     =  71
    var score: Int         =  0
    var highscore: Int     =  0
    var lives: Int         =  3
    var music: Bool        =  false
    var sound: Bool        =  true
}

var settings = Settings()

struct AppSettings {
    
    let spaceBarGameSettings = "SpaceBarTestFlightV002GameSettings"
    func saveUserDefaults() {
      UserDefaults.standard.set(try? PropertyListEncoder().encode(settings), forKey:spaceBarGameSettings)
    }

    func loadUserDefaults() {
        if let data = UserDefaults.standard.value(forKey:spaceBarGameSettings) as? Data,
           let disk = try? PropertyListDecoder().decode(Settings.self, from: data) {
            settings = disk
        }
    }
}

