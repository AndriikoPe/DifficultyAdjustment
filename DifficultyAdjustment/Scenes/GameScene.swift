//
//  GameScene.swift
//  DifficultyAdjustment
//
//  Created by Andriiko on 13.03.2023.
//

import SpriteKit

final class GameScene: SKScene {
    
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
    weak var gameStateDelegate: GameStateDelegate?
    
    lazy var player = PlayerNode(joystick: joystick)
    private var enemies = Set<EnemyBaseNode>()
    private var healthBars = [(SKSpriteNode, HealthBarNode)]()
    private let waveMaker = WaveMaker()
    private var timer: TimerNode?
    private lazy var fakeAgent = FakeAgent()
    private lazy var realAgent = RealAgent()
    private var waveDamage = [CGFloat]()
    private var playerHealth = AppConstants.playerInitialHealth
    
    override func didMove(to view: SKView) {
        backgroundColor = .black
        setupJoystick()
        setupPlayer()
        setupEnemyWaves()
        setupTimer()
        physicsWorld.contactDelegate = self
        gameStateDelegate?.updateDifficulty(AppConstants.gameDifficultyKnob)
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

    private func setupEnemyWaves() {
        run(.repeatForever(
            .sequence([
                .run { [weak self] in
                    self?.spawnWave()
                },
                .wait(forDuration: 15.0),
                .run { [weak self] in
                    guard let self else { return }
                    
                    let dh = self.playerHealth - self.player.health
                    self.playerHealth = self.player.health
                    self.waveDamage.append(dh)
                    
                    self.updateDifficulty()
                }
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
    
    private func spawnWave() {
        let wave = waveMaker.makeWave()
        
        wave.forEach { wavePiece in
            run(.sequence([
                .wait(forDuration: wavePiece.delay),
                .run { [weak self] in
                    guard let self else { return }
                    
                    let enemy = self.enemyNode(of: wavePiece.enemyType, direction: wavePiece.direction)
                    enemy.healthDelegate = self
                    enemy.position = wavePiece.position
                    
                    self.addChild(enemy)
                    self.enemies.insert(enemy)
                    
                    let healthBar = HealthBarNode(size: .init(width: enemy.size.width, height: 10.0))
                    self.addChild(healthBar)
                    
                    self.healthBars.append((enemy, healthBar))
                }
            ]))
        }
    }
    
    private func updateDifficulty() {
        guard let elapsedTime = timer?.elapsedTime, elapsedTime != .zero else { return }
        
        let state = WorldState(
            health: player.health,
            healthToTime: player.health / elapsedTime,
            timeElapsed: elapsedTime,
            damagedLastWave: waveDamage.last ?? .zero,
            avgWaveDamage: waveDamage.average(),
            factorDifference: AppConstants.initialDifiiculty - AppConstants.gameDifficultyKnob
        )
        
        switch AppConstants.regulator {
        case .random:
            fakeAgent.guessAndLog(for: state)
        case .real:
            Task {
                guard let action = try? await realAgent.getAction(for: state) else {
                    print("Action determining went wrong.")
                    return
                }
                
                await MainActor.run {
                    AppConstants.gameDifficultyKnob = action
                }
            }
        }
        
        
        gameStateDelegate?.updateDifficulty(AppConstants.gameDifficultyKnob)
    }
    
    private func setupTimer() {
        let timer = TimerNode()
        timer.position = CGPoint(x: 150.0, y: size.height - 100.0)
        addChild(timer)
        
        timer.start()
        self.timer = timer
    }
    
    private func enemyNode(of type: EnemyType, direction: CGFloat) -> EnemyBaseNode {
        switch type {
        case .justEnemy:
            return JustEnemyNode(
                texture: SKTexture(imageNamed: "enemyShip1"),
                healthDelegate: self,
                moveDirection: CGVector(dx: cos(direction), dy: sin(direction)))
        case .chasing:
            return ChasingEnemy(
                playerNode: self.player,
                healthDelegate: self)
        case .tank:
            return TankEnemy(
                healthDelegate: self,
                moveDirection: CGVector(dx: cos(direction), dy: sin(direction)))
        case .cannon:
            return CannonEnemy(
                healthDelegate: self,
                moveDirection: CGVector(dx: cos(direction), dy: sin(direction)))
        }
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
        let bar = healthBars.first(where: { $0.0 === node })?.1
        bar?.setHealth(newHealth)
        
        if node === player {
            if newHealth <= .zero {
                gameStateDelegate?.end(with: timer?.elapsedTime ?? .zero)
                isPaused = true
            }
        } else {
            if newHealth <= .zero {
                healthBars.removeAll(where: { $0.0 === node })
                if let enemy = node as? EnemyBaseNode { enemies.remove(enemy) }
                bar?.removeFromParent()
                node.removeFromParent()
                ExplosionNode.createExplosion(at: node.position, on: self, size: node.size * 0.7)
            }
        }
    }
}
