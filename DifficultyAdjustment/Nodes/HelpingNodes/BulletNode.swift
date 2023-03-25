//
//  BulletNode.swift
//  DifficultyAdjustment
//
//  Created by Andriiko on 16.03.2023.
//

import SpriteKit

final class Bullet: SKSpriteNode {
    
    enum Owner {
        case player
        case enemy
    }
    
    var moveSpeed: CGFloat = 1800.0
    
    init(owner: Owner, color: UIColor, size: CGSize) {
        super.init(texture: nil, color: color, size: size)
        
        zPosition = -1
        setupPhysicsBody(owner: owner)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func fire(from startPosition: CGPoint, in direction: CGFloat) {
        position = startPosition
        
        let velocity = CGPoint(x: cos(direction + CGFloat.pi / 2), y: sin(direction + CGFloat.pi / 2))
        let action = SKAction.sequence([
            SKAction.move(by: CGVector(dx: velocity.x * moveSpeed, dy: velocity.y * moveSpeed), duration: 3),
            SKAction.removeFromParent()
        ])
        
        run(action)
    }
    
    private func setupPhysicsBody(owner: Owner) {
        physicsBody = .init(rectangleOf: size)
        physicsBody?.isDynamic = false
        
        switch owner {
        case .player:
            physicsBody?.categoryBitMask = PhysicsCategory.playerBullet
            physicsBody?.contactTestBitMask = PhysicsCategory.enemy
        case .enemy:
            physicsBody?.categoryBitMask = PhysicsCategory.enemyBullet
            physicsBody?.contactTestBitMask = PhysicsCategory.player
        }
    }
}

extension Bullet: ColliderProtocol {
    func collide(with other: SKPhysicsBody, in scene: SKScene) {
        ExplosionNode.createExplosion(at: position, on: scene, size: size * 15.0)
        removeFromParent()
    }
}
