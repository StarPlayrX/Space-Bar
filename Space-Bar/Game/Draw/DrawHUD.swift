//
//  DrawHUD.swift
//  Space-Bar
//
//  Created by Todd Bruss on 11/8/22.
//  Copyright © 2022 Todd Bruss. All rights reserved.
//

import Foundation
import SpriteKit

extension GameScene {
    func drawHUD() {
        let puck = Global.shared.gameBall[settings.puck]

        livesLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.right
        livesLabel.verticalAlignmentMode = SKLabelVerticalAlignmentMode.center
        livesLabel.position = CGPoint(x: centerWidth - 9.5, y: -centerHeight + labelspace)
        livesLabel.zPosition = 50
        livesLabel.numberOfLines = 2
        livesLabel.text = String(repeating: puck + "\u{2005}", count: gameLives > 0 ? gameLives : 0)
        livesLabel.fontSize = 40
        livesLabel.alpha = 1.0
        livesLabel.fontColor = .clear
        anchorNode.addChild(livesLabel)
        
        levelLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
        levelLabel.verticalAlignmentMode = SKLabelVerticalAlignmentMode.center
        levelLabel.position = CGPoint(x: -centerWidth + 20, y: centerHeight - labelspace)
        levelLabel.zPosition = 50
        levelLabel.text = String(settings.currentlevel + 1)
        levelLabel.fontSize = 36
        levelLabel.fontColor = .systemRed
        levelLabel.alpha = 1.0
        anchorNode.addChild(levelLabel)
        
        scoreLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.right
        scoreLabel.verticalAlignmentMode = SKLabelVerticalAlignmentMode.center
        scoreLabel.fontColor = .white
        scoreLabel.position = CGPoint(x: centerWidth - 20, y: centerHeight - labelspace)
        scoreLabel.zPosition = 50
        scoreLabel.text = String(gameScore)
        scoreLabel.fontSize = 36
        scoreLabel.alpha = 1.0
        anchorNode.addChild(scoreLabel)
    }
}
