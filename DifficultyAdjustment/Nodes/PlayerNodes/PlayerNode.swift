//
//  PlayerNode.swift
//  DifficultyAdjustment
//
//  Created by Andriiko on 13.03.2023.
//

import SpriteKit

final class PlayerNode: SKSpriteNode {
    
    // MARK: - Tweakable params.
    
    var timeBetweenShots: TimeInterval = 0.2
    var isShooting = true
    var moveSpeed = 4.0
    var damageFromBullet = 0.05
    var damageFromEnemy = 0.1
    
    // MARK: - Other properties.
    
    weak var healthDelegate: HealthDelegate?
    private(set) var velocity = CGPoint.zero
    private(set) var lastShotTime: TimeInterval = 0
    private(set) var health = 1.0 {
        didSet {
            healthDelegate?.updateHealth(self, newHealth: health)
        }
    }
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
        
        let x = joystickVelocity.x * moveSpeed
        let y = joystickVelocity.y * moveSpeed
        
        velocity = CGPoint(x: x, y: y)
        
        if joystickVelocity != .zero {
            let angle = atan2(y, x)
            zRotation = angle - CGFloat.pi / 2
        }
        
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
    
    private func shoot() {
        let currentTime = CACurrentMediaTime()
        if currentTime - lastShotTime < timeBetweenShots {
            return
        }
        
        lastShotTime = currentTime
        
        let bullet = Bullet(owner: .player, color: .green, size: CGSize(width: 5, height: 5))
        bullet.fire(from: position, in: zRotation)
        
        parent?.addChild(bullet)
    }
}

extension PlayerNode: ColliderProtocol {
    func collide(with other: SKPhysicsBody, in scene: SKScene) {
        let p = PhysicsCategory.self
        
        switch other.categoryBitMask {
        case p.enemy:
            health -= damageFromEnemy
        case p.enemyBullet:
            health -= damageFromBullet
        default:
            break
        }
    }
}
