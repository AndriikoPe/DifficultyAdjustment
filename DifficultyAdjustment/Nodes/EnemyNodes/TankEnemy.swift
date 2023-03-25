//
//  TankEnemy.swift
//  DifficultyAdjustment
//
//  Created by Andriiko on 25.03.2023.
//

import SpriteKit

final class TankEnemy: EnemyBaseNode {
    init(healthDelegate: HealthDelegate) {
        super.init(
            texture: SKTexture(imageNamed: "enemyShip3"),
            healthDelegate: healthDelegate,
            health: 3.0,
            moveSpeed: 2.5,
            shootFrequency: 1.5
        )
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
