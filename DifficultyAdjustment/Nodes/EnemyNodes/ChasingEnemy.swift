//
//  ChasingEnemy.swift
//  DifficultyAdjustment
//
//  Created by Andriiko on 16.03.2023.
//

import SpriteKit

final class ChasingEnemy: EnemyBaseNode {
    
    private let playerNode: SKNode
    
    init(playerNode: SKNode, healthDelegate: HealthDelegate) {
        self.playerNode = playerNode
        
        super.init(
            texture: SKTexture(imageNamed: "enemyShip2"),
            healthDelegate: healthDelegate,
            moveSpeed: 12.0
        )
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func update() {
        let vectorToPlayer = CGVector(
            dx: playerNode.position.x - position.x,
            dy: playerNode.position.y - position.y
        )
    
        let directionToPlayer = CGVector(
            dx: vectorToPlayer.dx / vectorToPlayer.length,
            dy: vectorToPlayer.dy / vectorToPlayer.length
        )
        
        moveDirection = directionToPlayer
        
        zRotation = atan2(directionToPlayer.dy, directionToPlayer.dx) - CGFloat.pi/2
        
        super.update()
    }
    
    override func shoot() {
        // Does not shoot.
    }
}
