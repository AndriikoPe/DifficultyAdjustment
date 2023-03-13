//
//  JoystickNode.swift
//  DifficultyAdjustment
//
//  Created by Andriiko on 13.03.2023.
//

import SpriteKit
import GameplayKit

final class Joystick: SKNode {
    private let base: SKShapeNode
    private let knob: SKShapeNode
    private let joystickRadius: CGFloat
    private(set) var velocity = CGPoint.zero
    
    init(baseColor: UIColor, baseSize: CGSize, knobColor: UIColor, knobSize: CGSize, joystickRadius: CGFloat) {
        base = SKShapeNode(circleOfRadius: baseSize.width * 0.5)
        base.fillColor = baseColor

        knob = SKShapeNode(circleOfRadius: knobSize.width * 0.5)
        knob.fillColor = knobColor
        
        self.joystickRadius = joystickRadius
        
        super.init()
        
        isUserInteractionEnabled = true
        base.zPosition = 1
        addChild(base)
        
        knob.zPosition = 2
        addChild(knob)
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
    
    private func moveKnob(to position: CGPoint) {
        let distance = self.base.position.distance(to: position)
        let angle = self.base.position.angle(to: position)
        
        if distance <= self.joystickRadius {
            self.knob.position = position
        } else {
            self.knob.position = CGPoint(
                x: self.base.position.x + cos(angle) * self.joystickRadius,
                y: self.base.position.y + sin(angle) * self.joystickRadius)
        }
        
        self.velocity = CGPoint(x: cos(angle), y: sin(angle))
    }
    
    private func resetKnob() {
        let move = SKAction.move(to: self.base.position, duration: 0.1)
        move.timingMode = .easeOut
        self.knob.run(move)
        self.velocity = CGPoint.zero
    }
}
