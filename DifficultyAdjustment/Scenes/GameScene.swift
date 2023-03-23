//
//  GameScene.swift
//  DifficultyAdjustment
//
//  Created by Andriiko on 13.03.2023.
//

import SpriteKit

final class GameScene: SKScene {
    
    // MARK: - Constants.
    
    private enum C {
        enum Joystick {
            enum Base {
                static let size = CGSize(width: 300.0, height: 300.0)
                static let backgroundColor: UIColor = .gray.withAlphaComponent(0.4)
            }
            
            enum Knob {
                static let size = CGSize(width: 125.0, height: 125.0)
                static let backgroundColor: UIColor = .blue
            }
            
            static let radius = 125.0
            static let position = CGPoint(x: 400.0, y: 250.0)
        }
    }
    
    var joystick: Joystick = {
        let c = C.Joystick.self
        
        return Joystick(
            baseColor: c.Base.backgroundColor, baseSize: c.Base.size,
            knobColor: c.Knob.backgroundColor, knobSize: c.Knob.size,
            joystickRadius: c.radius)
    }()
    
    lazy var player = PlayerNode(joystick: joystick)
    private var enemies = Set<EnemyBaseNode>()
    private var healthBars = [(SKSpriteNode, HealthBarNode)]()
    
    override func didMove(to view: SKView) {
        backgroundColor = .black
        setupJoystick()
        setupPlayer()
        setupEnemyWaves()
        physicsWorld.contactDelegate = self
    }
    
    override func update(_ currentTime: TimeInterval) {
        player.update()
        enemies.forEach { $0.update() }
        healthBars.forEach { entity, bar in
            bar.position = .init(
                x: entity.position.x,
                y: entity.position.y - entity.size.width * 0.5 - 10.0)
        }
        
        let playableWidth = size.width - player.size.width
        let playableHeight = size.height - player.size.height
        let playableArea = CGRect(
            x: player.size.width * 0.5,
            y: player.size.height * 0.5,
            width: playableWidth,
            height: playableHeight
        )
        
        player.position += player.velocity
        player.position.x = max(min(player.position.x, playableArea.maxX), playableArea.minX)
        player.position.y = max(min(player.position.y, playableArea.maxY), playableArea.minY)
    }
    
    
    func updateTimeBetweenShots(_ timeBetweenShots: TimeInterval) {
        player.timeBetweenShots = timeBetweenShots
    }
    
    // MARK: - Setup.
    
    private func setupEnemyWaves() {
        run(.repeatForever(
            .sequence([
                .run { [weak self] in
                    guard let self else { return }
                    
                    let enemy = Bool.random() ?
                    JustEnemyNode(texture: SKTexture(imageNamed: "enemyShip1"), healthDelegate: self) :
                    ChasingEnemy(playerNode: self.player, healthDelegate: self)
                    
                    enemy.position = .init(x: 0, y: 400)
                    enemy.healthDelegate = self
                    self.addChild(enemy)
                    self.enemies.insert(enemy)
                },
                .wait(forDuration: 3.0)
            ])
        ))
    }
    
    private func setupJoystick() {
        self.joystick.position = C.Joystick.position
        self.addChild(self.joystick)
    }
    
    private func setupPlayer() {
        player = PlayerNode(joystick: joystick)
        player.position = CGPoint(x: size.width * 0.5, y: size.height * 0.5)
        player.isShooting = true
        player.healthDelegate = self
        addChild(player)
        
        let healthBar = HealthBarNode(
            size: .init(width: player.size.width, height: 10.0))
        addChild(healthBar)
        
        healthBars.append((player, healthBar))
    }
}

extension GameScene: SKPhysicsContactDelegate {
    func didBegin(_ contact: SKPhysicsContact) {
        let contactMask = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        let p = PhysicsCategory.self
        
        switch contactMask {
        case p.player | p.enemyBullet:
            break
        case p.player | p.enemy:
            break
        case p.enemy | p.playerBullet:
            break
        default:
            return
        }
        
        (contact.bodyA.node as? ColliderProtocol)?.collide(with: contact.bodyB, in: self)
        (contact.bodyB.node as? ColliderProtocol)?.collide(with: contact.bodyA, in: self)
    }
}

extension GameScene: HealthDelegate {
    func updateHealth(_ node: SKSpriteNode, newHealth: CGFloat) {
        healthBars.first(where: { $0.0 === player })?.1.setHealth(newHealth)
        
        if node === player {
            if newHealth <= .zero {
                // lose...
            }
        } else {
            if newHealth <= .zero {
                node.removeFromParent()
                ExplosionNode.createExplosion(at: node.position, on: self, size: node.size * 0.7)
            }
        }
    }
}
