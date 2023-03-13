//
//  JoystickNode.swift
//  DifficultyAdjustment
//
//  Created by Andriiko on 13.03.2023.
//

import SpriteKit
import GameplayKit

final class Joystick: SKNode {
    let base: SKSpriteNode
    let knob: SKSpriteNode
    let joystickRadius: CGFloat
    var velocity = CGPoint.zero
    
    init(baseColor: UIColor, baseSize: CGSize, knobColor: UIColor, knobSize: CGSize, joystickRadius: CGFloat) {
        self.base = SKSpriteNode(color: baseColor, size: baseSize)
        self.knob = SKSpriteNode(color: knobColor, size: knobSize)
        self.joystickRadius = joystickRadius
        
        super.init()
        
        self.isUserInteractionEnabled = true
        
        self.base.zPosition = 1
        self.addChild(self.base)
        
        self.knob.zPosition = 2
        self.addChild(self.knob)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let touchLocation = touch.location(in: self)
        self.moveKnob(to: touchLocation)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let touchLocation = touch.location(in: self)
        self.moveKnob(to: touchLocation)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.resetKnob()
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.resetKnob()
    }
    
    func moveKnob(to position: CGPoint) {
        let distance = self.base.position.distance(to: position)
        let angle = self.base.position.angle(to: position)
        
        if distance <= self.joystickRadius {
            self.knob.position = position
        } else {
            self.knob.position = CGPoint(x: self.base.position.x + cos(angle) * self.joystickRadius, y: self.base.position.y + sin(angle) * self.joystickRadius)
        }
        
        self.velocity = CGPoint(x: cos(angle), y: sin(angle))
    }
    
    func resetKnob() {
        let move = SKAction.move(to: self.base.position, duration: 0.1)
        move.timingMode = .easeOut
        self.knob.run(move)
        self.velocity = CGPoint.zero
    }
}
