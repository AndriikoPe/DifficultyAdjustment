//
//  CannonEnemy.swift
//  DifficultyAdjustment
//
//  Created by Andriiko on 26.03.2023.
//

import SpriteKit

final class CannonEnemy: EnemyBaseNode {
    private let bulletSize = CGSize(width: 5, height: 5)
    private let sectorAngle: CGFloat = 0.75 * .pi
    private let bulletsCount = 6
    private let delay = 0.1
    
    init(healthDelegate: HealthDelegate, moveDirection: CGVector) {
        super.init(
            texture: SKTexture(imageNamed: "enemyShip4"),
            healthDelegate: healthDelegate,
            moveSpeed: 2.5,
            moveDirection: moveDirection,
            shootFrequency: 2.0
        )
        
        start(moveDirection)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func start(_ moveDirection: CGVector) {
        run(.sequence([
            .move(by: moveDirection * 200.0, duration: 1.5),
            .repeatForever(.sequence([
                .run { [weak self] in self?.shoot() },
                .wait(forDuration: shootFrequency)
            ]))
        ]))
    }
    
    // Custom moving.
    override func update() {}
    
    override func shoot() {
        for i in 0..<bulletsCount {
            let bullet = Bullet(owner: .enemy, color: .red, size: bulletSize)
            let bulletAngle = (CGFloat(i) - CGFloat(bulletsCount - 1 ) / 2) * sectorAngle / CGFloat(bulletsCount - 1)
            let bulletRotation = zRotation + bulletAngle
                        
            run(.sequence([
                .wait(forDuration: delay * Double(i)),
                .run { [weak self] in
                    guard let self else { return }
                    
                    bullet.fire(from: self.position, in: bulletRotation)
                    self.parent?.addChild(bullet)
                }
            ]))
        }
    }
}
