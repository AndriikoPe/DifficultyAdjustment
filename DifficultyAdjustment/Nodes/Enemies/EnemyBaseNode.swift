//
//  EnemyNode.swift
//  DifficultyAdjustment
//
//  Created by Andriiko on 16.03.2023.
//

import SpriteKit

class EnemyBaseNode: SKSpriteNode {
    
    var moveSpeed: CGFloat = 5.0
    var moveDirection: CGVector = CGVector(dx: 1, dy: 0)
    var shootDirection: CGVector = CGVector(dx: 0, dy: 1)
    var shootFrequency: TimeInterval = 2.0

    func update() {
        let dx = moveDirection.dx * moveSpeed
        let dy = moveDirection.dy * moveSpeed
        position = CGPoint(x: position.x + dx, y: position.y + dy)

        shoot()
    }
    
    func shoot() {
        let currentTime = CACurrentMediaTime()
        if currentTime - lastShotTime < shootFrequency {
            return
        }
        
        lastShotTime = currentTime
        
        let bullet = Bullet(owner: .enemy, color: .red, size: .init(width: 5, height: 5))
        bullet.position = position
        
        parent?.addChild(bullet)
    }
    
    private var lastShotTime: TimeInterval = 0.0
}

