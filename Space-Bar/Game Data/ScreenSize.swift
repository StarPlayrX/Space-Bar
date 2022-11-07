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
        print("ratio:", ratio)
        
        if ratio == 8.0 {
            screenType = .iPad
            scene.size = CGSize(width: 1080.0 * 0.80, height: 1080.0)
        } else if ratio == 7.0 {
            screenType = .iPad
            scene.size = CGSize(width: 1080.0 * 0.70, height: 1080.0)
        } else if ratio == 6.0 {
            screenType = .iPhone
            scene.size = CGSize(width: 667.0 * 2.0 * 0.60, height: 667.0 * 2.0)
        } else if ratio == 5.0 {
            screenType = .iPhoneProMax
            scene.size = CGSize(width: 1300 * 0.50, height: 1300)
        }
        
        return screenType
    }
}

