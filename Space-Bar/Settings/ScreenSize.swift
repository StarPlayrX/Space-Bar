//
//  ScreenSize.swift
//  Space-Bar
//
//  Created by Todd Bruss on 10/5/22.
//  Copyright © 2022 Todd Bruss. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit

enum ScreenType : String {
    case iPhone = "iPhone"
    case iPhoneX = "iPhoneX"
    case iPhoneXMax = "iPhoneXMax"
    case iPhoneProMax = "iPhoneXSMax"
    case iPad = "iPad"
    case iAny = "iAny"
}

struct ScreenSize {
    
    static let shared = ScreenSize()
    
    func setSceneSizeForGame(scene:SKScene, size: CGSize) -> ScreenType {
        var screenType = ScreenType.iPhone
        let ratio = round((size.width / size.height ) * 10)
        let height = CGFloat(heightiOS)
        let width  = CGFloat(widthiOS)
       
        if ratio == 8.0 {
            screenType = .iPad
        } else if ratio == 7.0 {
            screenType = .iPad
        } else if ratio == 6.0 {
            screenType = .iPhone
        } else if ratio == 5.0 {
            screenType = .iPhoneProMax
        } else {
            screenType = .iAny
        }
        
        //Settling on a one size fits all otherwise it throws of the screen ratio in the game.
        scene.size = CGSize(width: width, height: height)
        
        return screenType
    }
}

