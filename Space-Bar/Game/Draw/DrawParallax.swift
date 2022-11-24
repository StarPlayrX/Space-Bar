//
//  DrawParallax.swift
//  Space-Bar
//
//  Created by Todd Bruss on 11/7/22.
//  Copyright © 2022 Todd Bruss. All rights reserved.
//

import Foundation
import SpriteKit

extension GameScene {
    func drawParallax() {
        let backParalax = SKNode()
        backParalax.position = CGPoint(x: CGFloat(centerWidth), y: CGFloat(centerHeight))
        let starryNightTexture = SKTexture(imageNamed: "starfield1")
        let height = starryNightTexture.size().height
        let moveGroundSprite = SKAction.moveBy(x: 0, y: -height, duration: TimeInterval(0.012 * height))
        let resetGroundSprite = SKAction.moveBy(x: 0, y: height, duration: 0.0)
        let moveGroundSpritesForever = SKAction.repeatForever(SKAction.sequence([moveGroundSprite,resetGroundSprite]))
        
        for i in -1...1 {
            autoreleasepool {
                let sprite = SKSpriteNode(texture: starryNightTexture)
                sprite.position = CGPoint(x: -centerWidth, y: CGFloat(i) * sprite.size.height)
                sprite.alpha = 0.85
                sprite.run(moveGroundSpritesForever)
                backParalax.addChild(sprite)
                backParalax.zPosition = -10
                backParalax.speed = 1
            }
        }
        anchorNode.addChild(backParalax)
    }
}
