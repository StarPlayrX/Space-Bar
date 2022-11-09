//
//  DrawLevel.swift
//  Space-Bar
//
//  Created by Todd Bruss on 11/7/22.
//  Copyright © 2022 Todd Bruss. All rights reserved.
//

import Foundation
import SpriteKit

extension GameScene {
    func drawLevel() {
        ballCounter = ballTimeOut * 2
        
        let lvlStr = String(settings.currentlevel + 1)
        let filename = "level\(lvlStr).sks"
        
        space = SKReferenceNode(fileNamed: filename)
        space?.name = "Space"
        
        guard let tilemap = space?.childNode(withName: "//bricks") as? SKTileMapNode else { return }
        
        for center in children {
            if center.name == "Center" {
                guard let space = space else { return }
                center.position = CGPoint(x: centerWidth, y: centerHeight)
                center.addChild(space)
            }
        }
        
        drawBricks(BricksTileMap: tilemap)
        
        var x: CGFloat = 0
        
        if xPos.indices.contains(settings.currentlevel) {
            x = xPos[settings.currentlevel] * 12.5
        }
        
        space?.position = screenType == .iPad ? CGPoint(x: x, y: centerHeight - 215) : CGPoint(x: x, y: centerHeight - 290)
        space?.xScale = screenType == .iPad ? 0.8 : 0.9
        space?.yScale = screenType == .iPad ? 0.8 : 0.9
    }
}
