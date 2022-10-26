//
//  Global.swift
//  Space-Bar
//
//  Created by Todd Bruss on 9/4/21.
//  Copyright © 2021 Todd Bruss. All rights reserved.
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
    var levels = ["😕", "🥸", "😛", "🤣", "😟", "😎", "😋", "😂", "😔", "🤓", "😚", "😅", "😞", "🧐", "😙", "😆", "😒", "🤨", "😗", "😁", "😏", "🤪", "😘", "😄", "🥳", "😜", "🥰", "😃", "🤩", "😝", "😍", "😀","😕", "🥸", "😛", "🤣", "😟","😕", "🥸", "😛", "🤣", "😟", "😎", "😋", "😂", "😔", "🤓", "😚", "😅", "😞", "🧐", "😙", "😆", "😒", "🤨", "😗", "😁", "😏", "🤪", "😘", "😄", "🥳", "😜", "🥰", "😃", "🤩", "😝", "😍", "😀","😕", "🥸", "😛", "🤣", "😟"]
    var initialScreenSize: CGSize?

}
