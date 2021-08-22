//
//  ScreenSize.swift
//  Space-Bar
//
//  Created by M1 on 8/21/21.
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
}

struct ScreenSize {
    
    static let shared = ScreenSize()
    
    func setSceneSizeForGame(scene:SKScene, size: CGSize) -> ScreenType {
        var screenType = ScreenType.iPhone
        let ratio = round((size.width / size.height ) * 10)
        
        if ratio == 8.0 {
            screenType = .iPad
            scene.size = CGSize(width: size.width, height: size.height)
        }
        
        print(ratio,size)
        
        
        return screenType
    }
}

