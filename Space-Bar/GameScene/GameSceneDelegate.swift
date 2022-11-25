//
//  Delegates.swift
//  Space-Bar
//
//  Created by Todd Bruss on 11/25/22.
//

import Foundation

protocol GameSceneDelegate: AnyObject {
    func playPause()
    func goLeft()
    func goRight()
    func moveLeft()
    func moveRight()
    func removeLeft()
    func removeRight()
}
