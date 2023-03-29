//
//  DataEntry.swift
//  DifficultyAdjustment
//
//  Created by Andriiko on 30.03.2023.
//

import Foundation

struct DataEntry {
    let health: CGFloat
    let healthToTime: CGFloat
    let damagedLastWave: CGFloat
    let avgWaveDamage: CGFloat
    let factorDifference: CGFloat
    let agentAction: CGFloat
    let agentReward: CGFloat
    
    func toCSV() -> String {
        let properties = [
            String(describing: health),
            String(describing: healthToTime),
            String(describing: damagedLastWave),
            String(describing: avgWaveDamage),
            String(describing: factorDifference),
            String(describing: agentAction),
            String(describing: agentReward)
        ]
        return properties.joined(separator: ",")
    }
}
