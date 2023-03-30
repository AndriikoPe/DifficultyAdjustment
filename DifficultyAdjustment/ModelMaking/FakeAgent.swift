//
//  FakeAgent.swift
//  DifficultyAdjustment
//
//  Created by Andriiko on 29.03.2023.
//

import Foundation

final class FakeAgent {
    private let logger = GameDataCollector()
    
    func guessAndLog(for state: WorldState) {
        var guess = CGFloat.random(in: -0.2...0.2)
        
        let newDifficulty = guess + AppConstants.gameDifficultyKnob
        if newDifficulty < 0.2 || newDifficulty > 1.8 {
            guess = 0.0
        }
        
        let newAccurateDifficulty = AppConstants.gameDifficultyKnob + guess
        let reward = evaluate(
            guess: guess,
            expectedHealth: expectedHealth(at: state.timeElapsed),
            currentHealth: state.health
        )
        
        logger.write(.init(
            health: state.health,
            healthToTime: state.healthToTime,
            timeElapsed: state.timeElapsed,
            damagedLastWave: state.damagedLastWave,
            avgWaveDamage: state.avgWaveDamage,
            factorDifference: state.factorDifference,
            currentDifficulty: newAccurateDifficulty,
            agentAction: guess,
            agentReward: reward
        ))
        
        AppConstants.gameDifficultyKnob = newAccurateDifficulty
    }
    
    private func evaluate(
        guess: CGFloat,
        expectedHealth: CGFloat,
        currentHealth: CGFloat
    ) -> CGFloat {
        let dh = abs(currentHealth - expectedHealth)
        
        if currentHealth > expectedHealth {
            return guess < 0 ? -dh : dh
        } else if currentHealth < expectedHealth {
            return guess < 0 ? dh : -dh
        }
    
        return guess * 0.01
    }
    
    private func expectedHealth(at timeElapsed: TimeInterval) -> CGFloat {
        1.0 - max(0.0, min(1.0, timeElapsed / AppConstants.targetPlayTime))
    }
}
