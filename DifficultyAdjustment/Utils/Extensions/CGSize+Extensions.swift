//
//  CGSize+Extensions.swift
//  DifficultyAdjustment
//
//  Created by Andriiko on 22.03.2023.
//

import UIKit

extension CGSize {
    static func * (size: CGSize, scalar: CGFloat) -> CGSize {
        return CGSize(width: size.width * scalar, height: size.height * scalar)
    }
}
