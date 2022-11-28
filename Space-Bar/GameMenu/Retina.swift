//
//  Retina.swift
//  Space-Bar
//
//  Created by Todd Bruss on 11/28/22.
//

import Foundation
import UIKit

extension UIScreen {

    public var getScale: CGFloat {
        return screenScale
    }

    public var screenScale: CGFloat {
        guard UIScreen.main.responds(to: #selector(getter: scale)) else {
            return 1.0
        }
        return UIScreen.main.scale
    }
}

