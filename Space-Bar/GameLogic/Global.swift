//
//  Global.swift
//  Space-Bar
//
//  Created by M1 on 9/4/21.
//  Copyright © 2021 Todd Bruss. All rights reserved.
//

import Foundation
import UIKit

struct Global {
    static let shared = Global()
    let gameBall: [String] = ["🤩","🥳","😏","😒","😞","😔","😟","😕"]
    let gameBallText: Array = ["blue","fuchsia","warm red","orange","magenta","bright green","green","purple rain"]
    let rotation = [0,45,90.0,135.0,180.0,225.0,270.0,315.0]
    let soundFx: Array = ["🔇","🔊"]
    let soundFxText: Array = ["no sound fx","sound fx"]
    let levels = ["😀","😍","😝","🤩","😃","🥰","😜","🥳","😄","😘","🤪","😏","😁","😗","🤨","😒","😆","😙","🧐","😞","😅","😚","🤓","😔","😂","😋","😎","😟","🤣","😛","🥸","😕"]
    var initialScreenSize: CGSize?

}
