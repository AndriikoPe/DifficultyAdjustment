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
    
    var moveSpeed: CGFloat = 1200.0
    
    init(owner: Owner, color: UIColor, size: CGSize) {
        super.init(texture: nil, color: color, size: size)
        zPosition = -1
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
}
