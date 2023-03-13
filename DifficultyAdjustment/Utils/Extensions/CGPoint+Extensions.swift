//
//  CGPoint+Extensions.swift
//  DifficultyAdjustment
//
//  Created by Andriiko on 13.03.2023.
//

import UIKit

extension CGPoint {
    func distance(to point: CGPoint) -> CGFloat {
        return sqrt(pow(point.x - self.x, 2) + pow(point.y - self.y, 2))
    }
    
    func angle(to point: CGPoint) -> CGFloat {
        return atan2(point.y - self.y, point.x - self.x)
    }
}
