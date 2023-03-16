//
//  CGPoint+Extensions.swift
//  DifficultyAdjustment
//
//  Created by Andriiko on 13.03.2023.
//

import UIKit

extension CGPoint {
    func distance(to point: CGPoint) -> CGFloat {
        sqrt(pow(point.x - self.x, 2) + pow(point.y - self.y, 2))
    }
    
    func angle(to point: CGPoint) -> CGFloat {
        atan2(point.y - self.y, point.x - self.x)
    }
    
    static func * (point: CGPoint, scalar: CGFloat) -> CGPoint {
        CGPoint(x: point.x * scalar, y: point.y * scalar)
    }
    
    static func += (lhs: inout CGPoint, rhs: CGPoint) {
        lhs.x += rhs.x
        lhs.y += rhs.y
    }
}
