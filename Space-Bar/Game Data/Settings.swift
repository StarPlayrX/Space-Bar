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
    var currentlevel: Int  =  0
    var maxlevel    : Int  =  71 // Not currently in use
    var highlevel   : Int  =  100
    var score       : Int  =  0
    var highscore   : Int  =  0
    var lives       : Int  =  3
    var music       : Bool =  false // Not currently in use
    var sound       : Bool =  true
}

var settings = Settings()

struct AppSettings {
    let spaceBarGameSettings = "SpaceBarGameSettingsV1RC5"
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

