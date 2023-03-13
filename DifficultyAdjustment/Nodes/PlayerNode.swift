//
//  PlayerNode.swift
//  DifficultyAdjustment
//
//  Created by Andriiko on 13.03.2023.
//

import SpriteKit

final class PlayerNode: SKSpriteNode {
    
    var velocity = CGPoint.zero
    var lastShotTime: TimeInterval = 0
    var timeBetweenShots: TimeInterval = 0.2
    var isShooting = true
    private let joystick: Joystick
    
    init(joystick: Joystick) {
        self.joystick = joystick
        
        let texture = SKTexture(imageNamed: "playerShip")
        super.init(texture: texture, color: .clear, size: texture.size())
        
        physicsBody = SKPhysicsBody(rectangleOf: size)
        physicsBody?.categoryBitMask = PhysicsCategory.player
        physicsBody?.contactTestBitMask = PhysicsCategory.enemy
        physicsBody?.collisionBitMask = PhysicsCategory.none
        physicsBody?.usesPreciseCollisionDetection = true
        physicsBody?.affectedByGravity = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update() {
        let joystickVelocity = joystick.velocity
        let speed = CGFloat(150.0)
        
        let x = joystickVelocity.x * speed
        let y = joystickVelocity.y * speed
        
        velocity = CGPoint(x: x, y: y)
        
        let angle = atan2(y, x)
        zRotation = angle - CGFloat.pi / 2
        
        if isShooting {
            shoot()
        }
    }
    
    func pauseShooting() {
        isShooting = false
        removeAllActions()
    }
    
    func resumeShooting() {
        isShooting = true
        shoot()
    }
    
    func setTimeBetweenShots(_ time: TimeInterval) {
        timeBetweenShots = time
    }
    
    private func shoot() {
        let currentTime = CACurrentMediaTime()
        if currentTime - lastShotTime < timeBetweenShots {
            return
        }
        
        lastShotTime = currentTime
        
        let bullet = SKSpriteNode(color: .green, size: CGSize(width: 5, height: 5))
        bullet.zPosition = -1
        bullet.position = position
        
        let bulletVelocity = CGPoint(x: cos(zRotation + CGFloat.pi / 2), y: sin(zRotation + CGFloat.pi / 2))
        let bulletAction = SKAction.sequence([
            SKAction.move(by: CGVector(dx: bulletVelocity.x * 1000, dy: bulletVelocity.y * 1000), duration: 3),
            SKAction.removeFromParent()
        ])
        bullet.run(bulletAction)
        
        parent?.addChild(bullet)
    }
}
