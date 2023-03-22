//
//  ColliderProtocol.swift
//  DifficultyAdjustment
//
//  Created by Andriiko on 22.03.2023.
//

import SpriteKit

protocol ColliderProtocol {
    func collide(with other: SKPhysicsBody, in scene: SKScene)
}
