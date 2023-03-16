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
    
    init(
        texture: SKTexture,
        moveSpeed: CGFloat = 5.0,
        moveDirection: CGVector = CGVector(dx: 1, dy: 0),
        shootDirection: CGVector = CGVector(dx: 0, dy: 1),
        shootFrequency: TimeInterval = 2.0,
        lastShotTime: TimeInterval = 0.0
    ) {
        self.moveSpeed = moveSpeed
        self.moveDirection = moveDirection
        self.shootDirection = shootDirection
        self.shootFrequency = shootFrequency
        self.lastShotTime = lastShotTime
        
        super.init(texture: texture, color: .clear, size: texture.size())
        
        zRotation = atan2(moveDirection.dy, moveDirection.dx) - CGFloat.pi/2
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

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
        bullet.fire(from: position, in: zRotation)
        
        parent?.addChild(bullet)
    }
    
    private var lastShotTime: TimeInterval = 0.0
}

