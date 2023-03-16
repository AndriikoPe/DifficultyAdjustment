//
//  CGVector+Extensions.swift
//  DifficultyAdjustment
//
//  Created by Andriiko on 16.03.2023.
//

import UIKit

extension CGVector {
    var length: CGFloat {
        return sqrt(dx*dx + dy*dy)
    }
}
