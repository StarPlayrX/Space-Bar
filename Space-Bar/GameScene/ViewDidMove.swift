//
//  ViewDidMove.swift
//  Space-Bar
//
//  Created by Todd Bruss on 11/7/22.
//  Copyright © 2022 Todd Bruss. All rights reserved.
//

import Foundation
import SpriteKit




extension GameScene {
    override func didMove(to view: SKView) {
        g.showCursor = false
        NSCursor.hide()
        
        let mouseInput = UIHoverGestureRecognizer(
            target: self,
            action: #selector(mouseDidMove(_:)))
        
        view.addGestureRecognizer(mouseInput)
        
        screenType = ScreenSize.shared.setSceneSizeForGame(scene: self, size: initialScreenSize)
        
        guard
            let w = scene?.size.width,
            case let h = (scene?.size.height ?? 0) - yCoverMacOS
        else {
            return
        }
        
        width  = w
        height = h
        
        centerWidth  = width / 2
        centerHeight = height / 2
        
        anchor = CGPoint(x: centerWidth, y: centerHeight)
        anchorNode.position = anchor
        scene?.addChild(anchorNode)
        
        //MARK: - Game Frame
        let frame = CGRect(x: -centerWidth, y: -centerHeight, width: width, height: height)
        drawEdgeLoop(frame)
        
        drawParallax()
    
        bonusLives(minor: true, major: false, large: true)
        
        drawHUD()
        drawMidCorners()
        drawCenterCourt()
        drawWalls()
        drawGoal()
        drawPaddle()
        drawLevel()
        getReady()
    }
    
    func bonusLives(minor: Bool, major: Bool, large: Bool) {
        if gameLives >= 5 {
            return
        }
        
        if (settings.currentlevel + 1) % 5 == 0 {
           if minor { gameLives += 1 }
        }
    }
}
