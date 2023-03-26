//
//  TimerNode.swift
//  DifficultyAdjustment
//
//  Created by Andriiko on 26.03.2023.
//

import SpriteKit

final class TimerNode: SKNode {
    private var startTime: TimeInterval = 0
    private(set) var elapsedTime: TimeInterval = 0
    
    private var timerLabel: SKLabelNode!
    private var isRunning: Bool = false
    
    override init() {
        super.init()
        
        timerLabel = SKLabelNode(text: "00:00")
        timerLabel.fontName = "Helvetica"
        timerLabel.fontSize = 48
        timerLabel.horizontalAlignmentMode = .center
        timerLabel.verticalAlignmentMode = .center
        
        addChild(timerLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func start() {
        if !isRunning {
            isRunning = true
            startTime = Date.timeIntervalSinceReferenceDate - elapsedTime
            
            let update = SKAction.run { [weak self] in
                self?.updateElapsedTime()
            }
            
            let delay = SKAction.wait(forDuration: 1.0)
            let sequence = SKAction.sequence([delay, update])
            let repeatForever = SKAction.repeatForever(sequence)
            
            run(repeatForever)
        }
    }
    
    func stop() {
        isRunning = false
        elapsedTime = Date.timeIntervalSinceReferenceDate - startTime
        removeAllActions()
    }
    
    func reset() {
        isRunning = false
        startTime = 0
        elapsedTime = 0
        updateLabel(time: elapsedTime)
        removeAllActions()
    }
    
    private func updateElapsedTime() {
        elapsedTime = Date.timeIntervalSinceReferenceDate - startTime
        updateLabel(time: elapsedTime)
    }
    
    private func updateLabel(time: TimeInterval) {
        let minutes = Int(time / 60)
        let seconds = Int(time) % 60
        
        let minutesString = String(format: "%02d", minutes)
        let secondsString = String(format: "%02d", seconds)
        
        timerLabel.text = "\(minutesString):\(secondsString)"
    }
}
