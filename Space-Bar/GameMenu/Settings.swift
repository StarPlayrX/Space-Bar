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
    var highlevel   : Int  =  1
    var score       : Int  =  0
    var highscore   : Int  =  0
    var lives       : Int  =  3
    var sound       : Bool =  true
}

struct AppSettings {
    let spaceBarGameSettings = "SpaceBarGameSettingsX1"
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
