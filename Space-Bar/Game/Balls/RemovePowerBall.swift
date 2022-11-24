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
        for fireball in anchorNode.children {
            if let name = fireball.name, name.contains("fireball") {
                fireball.removeFromParent()
            }
        }
    }
    
    func removeFireBall(willFade: Bool) {
        guard let children = scene?.children else { return }
    
        let fade = SKAction.fadeOut(withDuration: 0.334)
        let stop = SKAction.removeFromParent()
        let actn = SKAction.sequence([fade,stop])
        
        
        for fireball in children {
            if let name = fireball.name, name.contains("fireball") {
                if willFade {
                    fireball.run(actn)
                } else {
                    fireball.removeFromParent()
                }
            }
        }
    }
    
    func removeBall() {
        for fireball in anchorNode.children {
            if let name = fireball.name, name.contains("ball") {
                fireball.removeFromParent()
            }
        }
    }
}
