//
//  RemovePowerBall.swift
//  Space-Bar
//
//  Created by Todd Bruss on 11/7/22.
//  Copyright © 2022 Todd Bruss. All rights reserved.
//

import Foundation
import SpriteKit

extension GameScene {
    func removePowerBall() {
        // Ensures no pucks pre-exist
        for whatDaPuck in anchorNode.children {
            if let name = whatDaPuck.name, name.contains("powerball") {
                whatDaPuck.removeFromParent()
            }
        }
    }
}
