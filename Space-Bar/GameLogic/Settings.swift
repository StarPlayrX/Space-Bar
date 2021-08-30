//
//  Settings.swift
//  Space-Bar
//
//  Created by M1 on 8/29/21.
//  Copyright © 2021 Todd Bruss. All rights reserved.
//

import Foundation

struct Settings: Codable {
    var level: Int      = 1
    var highlevel: Int  = 2
    var score: Int      = 0
    var highscore: Int  = 0
    var lives: Int      = 9
    var music: Bool     = false
    var sound: Bool     = true
}

var settings = Settings()

struct AppSettings {    
    func saveUserDefaults() {
        UserDefaults.standard.set(try? PropertyListEncoder().encode(settings), forKey:"settings")
    }

    func loadUserDefaults() {
        if let data = UserDefaults.standard.value(forKey:"settings") as? Data,
           let disk = try? PropertyListDecoder().decode(Settings.self, from: data) {
            settings = disk
        }
    }
}

