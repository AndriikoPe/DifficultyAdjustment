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
                static let size = CGSize(width: 400.0, height: 400.0)
                static let backgroundColor: UIColor = .gray
            }
            
            enum Knob {
                static let size = CGSize(width: 200.0, height: 200.0)
                static let backgroundColor: UIColor = .blue
            }
            
            static let radius = 200.0
            static let position = CGPoint(x: 400.0, y: 300.0)
        }
    }
    
    var joystick: Joystick!
    
    override func didMove(to view: SKView) {
        backgroundColor = UIColor.white
        setupJoystick()
    }
    
    // MARK: - Setup.
    
    private func setupJoystick() {
        let c = C.Joystick.self
        
        self.joystick = Joystick(
            baseColor: c.Base.backgroundColor, baseSize: c.Base.size,
            knobColor: c.Knob.backgroundColor, knobSize: c.Knob.size,
            joystickRadius: c.radius)
        
        self.joystick.position = c.position
        self.addChild(self.joystick)
    }
}
