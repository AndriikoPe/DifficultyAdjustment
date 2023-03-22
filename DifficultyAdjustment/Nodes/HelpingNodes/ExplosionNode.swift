//
//  ExplosionNode.swift
//  DifficultyAdjustment
//
//  Created by Andriiko on 22.03.2023.
//

import SpriteKit

final class ExplosionNode: SKSpriteNode {
    private static let textureAtlas = SKTextureAtlas(named: "Explosion")
    private static let textures = (1...11).map {
        textureAtlas.textureNamed("Explosion1_\($0)")
    }

    static func createExplosion(at point: CGPoint, on scene: SKScene, size: CGSize) {
        let explosion = ExplosionNode(size: size)
        explosion.position = point
        explosion.zPosition = 100
        scene.addChild(explosion)
        
        let animateAction = SKAction.animate(with: textures, timePerFrame: 0.05)
        let removeAction = SKAction.removeFromParent()
        let sequence = SKAction.sequence([animateAction, removeAction])
        explosion.run(sequence)
    }
    
    private init(size: CGSize) {
        super.init(texture: nil, color: .clear, size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
