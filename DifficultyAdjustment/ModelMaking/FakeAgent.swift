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
        var guess = CGFloat.random(in: -0.5...0.5)
        
        let newDifficulty = guess + AppConstants.gameDifficultyKnob
        if newDifficulty < 0.2 || newDifficulty > 1.8 {
            guess = 0.0
        }
        
        let newAccurateDifficulty = AppConstants.gameDifficultyKnob + guess
        let reward = evaluate(
            guess: newAccurateDifficulty,
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
        let guessDescription = guess > 0 ? "increased" : (guess < 0 ? "decreased" : "not changed")
        print("Game difficulty " + guessDescription)
        print("New difficulty: \(AppConstants.gameDifficultyKnob)")
        print("Current health: \(state.health)")
        print("Expected health: \(expectedHealth(at: state.timeElapsed))")
        print("Reward: \(reward)\n")
    }
    
    private func evaluate(
        guess: CGFloat,
        expectedHealth: CGFloat,
        currentHealth: CGFloat
    ) -> CGFloat {
        let dh = currentHealth - expectedHealth
        
        if currentHealth > expectedHealth {
            return guess < 0 ? dh : -dh
        } else if currentHealth < expectedHealth {
            return guess > 0 ? dh : -dh
        }
    
        return guess * 0.01
    }
    
    private func expectedHealth(at timeElapsed: TimeInterval) -> CGFloat {
        1.0 - max(0.0, min(1.0, timeElapsed / AppConstants.targetPlayTime))
    }
}
