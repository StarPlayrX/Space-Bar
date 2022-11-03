//
//  LevelPosition.swift
//  Space-Bar
//
//  Created by Todd Bruss on 9/8/21.
//  Copyright © 2021 Todd Bruss. All rights reserved.
//

import UIKit

// Adjust the positioning of the pattern
// Square Patterns are always 0 unless off center then it's ± 2 (Centered)
// Hex patterns are always 1 or -1 (Bump Right +1, Bump Left -1)
let xPos: [CGFloat] = [
//  1   2   3   4   5   6   7   8   9  10
    0,  1,  0,  0,  0,  1, -2,  0,  0,  1, // 10
   -2,  1,  0, -1,  0,  1,  0, -1, -2,  0, // 20
   -1,  0, -1,  0,  1,  0, -1,  0,  1,  0, // 30
  1.5,  0,  3,  0,  1,  2,  0, -1,  0,  0, // 40
    1,  0, -1,  1,  1,  0,  1,  1, -1,  0, // 50
   -1,  0,  0,  1,  0,  0,  3, -1, -1,  0, // 60
    0,  0,  0,  0,  0,  0,  0,  0,  2,  0,
   -2,  0,  2   // Bonus Levels 61 - 73
]

