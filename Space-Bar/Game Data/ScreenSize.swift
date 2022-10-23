//
//  ScreenSize.swift
//  Space-Bar
//
//  Created by Todd Bruss on 8/21/21.
//  Copyright © 2021 Todd Bruss. All rights reserved.
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
        
        if ratio == 8.0 {
            screenType = .iPad
            scene.size = CGSize(width: 810.0, height: 1080.0)
        } else if ratio == 7.0 {
            screenType = .iPad
            scene.size = CGSize(width: 810.0, height: 1080.0 - 20)
        } else if ratio == 6.0 {
            screenType = .iPhone
            scene.size = CGSize(width: 375.0 * 2.0, height: 667.0 * 2.0)
        } else if ratio == 5.0 {
            screenType = .iPhoneProMax
            scene.size = CGSize(width: 700, height: 1300)
        }
        
        return screenType
    }
}

