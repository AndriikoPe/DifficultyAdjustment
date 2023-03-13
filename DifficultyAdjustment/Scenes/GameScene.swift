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
    
    override func didMove(to view: SKView) {
        backgroundColor = .black
        setupJoystick()
        setupPlayer()
    }
    
    override func update(_ currentTime: TimeInterval) {
        player.update()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let touchLocation = touch.location(in: self)
//            if pauseButton.contains(touchLocation) {
//                player.pauseShooting()
//            } else if resumeButton.contains(touchLocation) {
//                player.resumeShooting()
//            }
        }
    }

    // Handle changes to the time between shots
    func updateTimeBetweenShots(_ timeBetweenShots: TimeInterval) {
        player.timeBetweenShots = timeBetweenShots
    }
    // MARK: - Setup.
    
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
