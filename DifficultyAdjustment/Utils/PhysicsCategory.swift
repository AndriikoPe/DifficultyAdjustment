//
//  PhysicsCategory.swift
//  DifficultyAdjustment
//
//  Created by Andriiko on 14.03.2023.
//

import Foundation

enum PhysicsCategory {
    static let none: UInt32 = 0
    static let player: UInt32 = 0b1 // 1
    static let enemy: UInt32 = 0b10 // 2
    static let enemyBullet: UInt32 = 0b100 // 4
    static let playerBullet: UInt32 = 0b100 // 4
}
