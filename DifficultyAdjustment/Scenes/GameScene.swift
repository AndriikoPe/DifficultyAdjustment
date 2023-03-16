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
    
    override func didMove(to view: SKView) {
        backgroundColor = .black
        setupJoystick()
        setupPlayer()
        setupEnemyWaves()
    }
    
    override func update(_ currentTime: TimeInterval) {
        player.update()
        enemies.forEach { $0.update() }
        
        // Calculate the bounds of the playable area
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
                    let enemy = JustEnemyNode(texture: SKTexture(imageNamed: "enemyShip1"))
                    
                    enemy.position = .init(x: 0, y: 400)
                    self?.addChild(enemy)
                    self?.enemies.insert(enemy)
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
        addChild(player)
    }
}
