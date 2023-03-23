//
//  HealthDelegate.swift
//  DifficultyAdjustment
//
//  Created by Andriiko on 22.03.2023.
//

import SpriteKit

protocol HealthDelegate: AnyObject {
    func updateHealth(_ node: SKSpriteNode, newHealth: CGFloat)
}
