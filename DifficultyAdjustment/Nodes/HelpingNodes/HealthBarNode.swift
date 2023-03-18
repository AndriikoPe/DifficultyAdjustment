//
//  HealthBarNode.swift
//  DifficultyAdjustment
//
//  Created by Andriiko on 18.03.2023.
//

import SpriteKit

final class HealthBarNode: SKSpriteNode {
    private let healthBackground: SKSpriteNode
    private let healthFill: SKSpriteNode
    
    init(size: CGSize, initialHealth: CGFloat = 1.0) {
        healthBackground = SKSpriteNode(color: .red, size: size)
        healthBackground.anchorPoint = CGPoint(x: 0, y: 0.5)
        healthBackground.position.x = -size.width / 2
        
        healthFill = SKSpriteNode(color: .green, size: size)
        healthFill.anchorPoint = CGPoint(x: 0, y: 0.5)
        healthFill.position.x = -size.width / 2
        
        super.init(texture: nil, color: .clear, size: size)
        
        addChild(healthBackground)
        addChild(healthFill)
        
        setHealth(initialHealth)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setHealth(_ health: CGFloat) {
        let healthPercentage = max(min(health, 1), 0)
        healthFill.xScale = healthPercentage
    }
}
