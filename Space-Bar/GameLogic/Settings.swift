//
//  Settings.swift
//  Space-Bar
//
//  Created by M1 on 8/29/21.
//  Copyright © 2021 Todd Bruss. All rights reserved.
//

import Foundation
import UIKit

struct Settings: Codable {
    var puck: Int          =  0
    var level: Int         =  0
    var currentlevel: Int  =  0
    var highlevel: Int     =  0
    var score: Int         =  0
    var highscore: Int     =  0
    var lives: Int         =  3
    var music: Bool        =  false
    var sound: Bool        =  true
    var initialScreenSize: CGSize?
}

var settings = Settings()

struct AppSettings {
    let settingsKey = "settingsKey"
    func saveUserDefaults() {
        UserDefaults.standard.set(try? PropertyListEncoder().encode(settings), forKey: settingsKey)
    }

    func loadUserDefaults() {
        if let data = UserDefaults.standard.value(forKey: settingsKey) as? Data,
           let disk = try? PropertyListDecoder().decode(Settings.self, from: data) {
            settings = disk
        }
    }
}

