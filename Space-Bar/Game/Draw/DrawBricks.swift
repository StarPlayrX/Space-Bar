//
//  DrawBricks.swift
//  Space-Bar
//
//  Created by Todd Bruss on 11/7/22.
//  Copyright © 2022 Todd Bruss. All rights reserved.
//

import Foundation
import SpriteKit

extension GameScene {
    //Draws our Bricks for us
    func Drawbricks(BricksNode: SKSpriteNode, TileMapNode:SKTileMapNode, center: CGPoint) {
        let rotation = Global.shared.rotation
        let spriteLabelNode = SKLabelNode(fontNamed:"SpaceBarColors")
        spriteLabelNode.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.center
        spriteLabelNode.verticalAlignmentMode = SKLabelVerticalAlignmentMode.center
        spriteLabelNode.alpha = 1.0
        spriteLabelNode.position = CGPoint(x: 0, y: 0)
        spriteLabelNode.fontSize = 50
        spriteLabelNode.zRotation = CGFloat(Int(rotation[settings.currentlevel % rotation.count]).degrees)
        
        let artwork = levelart[settings.currentlevel % levelart.count]
        
        if let art = artwork {
            let coinToss = Int(arc4random_uniform(UInt32(art.count)) )
            spriteLabelNode.text = art[coinToss]
            BricksNode.addChild(spriteLabelNode)
        }
        
        if let texture = view?.texture(from: spriteLabelNode) {
            BricksNode.physicsBody = SKPhysicsBody(texture: texture, alphaThreshold: 0.1, size: texture.size())
        } else {
            // This fall back should not happen, but we may use this in the future for iOS' that fail
            BricksNode.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 48, height: 48))
        }
        
        BricksNode.zPosition = 50
        BricksNode.physicsBody?.restitution = 0.25
        BricksNode.physicsBody?.categoryBitMask = brickCategory
        BricksNode.physicsBody?.collisionBitMask = ballCategory + powerCategory + fireBallCategory
        BricksNode.physicsBody?.fieldBitMask = ballCategory + powerCategory + fireBallCategory
        BricksNode.physicsBody?.contactTestBitMask = ballCategory + powerCategory + fireBallCategory
        BricksNode.physicsBody?.allowsRotation = false
        BricksNode.physicsBody?.affectedByGravity = false
        BricksNode.physicsBody?.isDynamic = false
        BricksNode.physicsBody?.pinned = false
        BricksNode.physicsBody?.isResting = false
        BricksNode.physicsBody?.friction = 0.0
        BricksNode.physicsBody?.mass = 0.5
        BricksNode.name = "brick"
        BricksNode.position = center
        
        space?.addChild(BricksNode)
    }
    
    func drawBricks(BricksTileMap: SKTileMapNode)  {
        for col in (0 ..< BricksTileMap.numberOfColumns) {
            autoreleasepool {
                for row in (0 ..< BricksTileMap.numberOfRows) {
                    autoreleasepool {
                        if let _ = BricksTileMap.tileDefinition(atColumn: col, row: row) {
                            let center = BricksTileMap.centerOfTile(atColumn: col, row: row)
                            tileMapRun(TileMapNode: BricksTileMap, center: center)
                        }
                    }
                }
            }
        }
        
        BricksTileMap.removeAllChildren()
        BricksTileMap.removeFromParent()
    }
}
