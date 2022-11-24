//
//  Global.swift
//  Space-Bar
//
//  Created by Todd Bruss on 10/5/22.
//  Copyright © 2022 Todd Bruss. All rights reserved.
//

import Foundation
import UIKit

struct Global {
    static var shared = Global()
    let gameBall: [String] = ["🤩","🥳","😏","😒","😞","😔","😟","😕"]
    let gameBallText: Array = ["blue","fuchsia","warm red","orange","magenta","bright green","green","purple rain"]
    var rotation = [315.0, 270.0, 225.0, 180.0, 135.0, 90.0, 45.0, 0.0]
    let soundFx: Array = ["🔇","🔊"]
    let soundFxText: Array = ["no sound fx","sound fx"]
    var levels = [
                  //1     2     3     4     5     6     7     8
                  "😕", "🥸", "😛", "🤣", "😟", "😎", "😋", "😂",
                  "😔", "🤓", "😚", "😅", "😞", "🧐", "😙", "😆", //16
                  "😒", "🤨", "😗", "😁", "😏", "🤪", "😘", "😄", //24
                  "🥳", "😜", "🥰", "😃", "🤩", "😝", "😍", "😀", //32
                  
                  "😕", "🥸", "😛", "🤣", "😟", "😎", "😋", "😂", //40
                  "😔", "🤓", "😚", "😅", "😞", "🧐", "😙", "😆", //48
                  "😒", "🤨", "😗", "😁", "😏", "🤪", "😘", "😄", //56
                  "🥳", "😜", "🥰", "😃", "🤩", "😝", "😍", "😀", //64
                  
                  "😕", "🥸", "😛", "🤣", "😟", "😎", "😋", "😂", //72
                  "😔", "🤓", "😚", "😅", "😞", "🧐", "😙", "😆", //80
                  "😒", "🤨", "😗", "😁", "😏", "🤪", "😘", "😄", //88
                  "🥳", "😜", "🥰", "😃", "🤩", "😝", "😍", "😀", //96
                  "🥳", "😜", "🥰", "😃", //100
                  ]
    var initialScreenSize: CGSize?
    let constraint = CGFloat(64)
    let windspeed: Double = 0.3
    let movement: Double = 10
    let moveLeft: String = "moveLeft"
    let moveRight: String = "moveRight"
    var showCursor: Bool = true
}
