//
//  EnemyNode.swift
//  DifficultyAdjustment
//
//  Created by Andriiko on 16.03.2023.
//

import SpriteKit

class EnemyBaseNode: SKSpriteNode {
    var moveDirection: CGVector
    var moveSpeed: CGFloat
    var damageOnHit: CGFloat
    var shootFrequency: TimeInterval
    weak var healthDelegate: HealthDelegate?
    
    
    private(set) var health: CGFloat {
        didSet {
            healthDelegate?.updateHealth(self, newHealth: health)
        }
    }
    private var lastShotTime: TimeInterval = 0.0
    private var enteringScreen = false
    
    init(
        texture: SKTexture,
        healthDelegate: HealthDelegate?,
        health: CGFloat = 1.0,
        moveSpeed: CGFloat = 5.0,
        moveDirection: CGVector = CGVector(dx: 1, dy: 0),
        shootFrequency: TimeInterval = 2.0,
        damageOnHit: CGFloat = 0.35,
        lastShotTime: TimeInterval = 0.0
    ) {
        self.health = health
        self.moveSpeed = moveSpeed
        self.moveDirection = moveDirection
        self.shootFrequency = shootFrequency
        self.lastShotTime = lastShotTime
        self.damageOnHit = damageOnHit
        
        super.init(texture: texture, color: .clear, size: texture.size())
        
        setupPhysicsBody()
        zRotation = atan2(moveDirection.dy, moveDirection.dx) - CGFloat.pi/2
    }
    
    private func setupPhysicsBody() {
        physicsBody = SKPhysicsBody(rectangleOf: size)
        physicsBody?.categoryBitMask = PhysicsCategory.enemy
        physicsBody?.contactTestBitMask = PhysicsCategory.player
        physicsBody?.collisionBitMask = PhysicsCategory.player
        physicsBody?.affectedByGravity = false
        physicsBody?.allowsRotation = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func update() {
        let dx = moveDirection.dx * moveSpeed
        let dy = moveDirection.dy * moveSpeed
        position = CGPoint(x: position.x + dx, y: position.y + dy)

        let sceneSize = AppConstants.sceneSize
        if !enteringScreen {
               if position.x >= -size.width / 2 && position.x <= sceneSize.width + size.width / 2 &&
                   position.y >= -size.height / 2 && position.y <= sceneSize.height + size.height / 2 {
                   enteringScreen = true
               }
           } else {
               if position.x < -size.width / 2 ||
                  position.x > sceneSize.width + size.width / 2 ||
                  position.y < -size.height / 2 ||
                  position.y > sceneSize.height + size.height / 2 {
                   healthDelegate?.updateHealth(self, newHealth: 0)
               }
           }
        
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
}

extension EnemyBaseNode: ColliderProtocol {
    func collide(with other: SKPhysicsBody, in scene: SKScene) {
        let p = PhysicsCategory.self
        
        switch other.categoryBitMask {
        case p.player:
            health = .zero
        case p.playerBullet:
            health -= damageOnHit
        default: return
        }
    }
}
