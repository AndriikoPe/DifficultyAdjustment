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
    
    static func *(lhs: CGVector, rhs: CGFloat) -> CGVector {
        return CGVector(dx: lhs.dx * rhs, dy: lhs.dy * rhs)
    }
}
