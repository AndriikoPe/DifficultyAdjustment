//
//  WorldStateDto.swift
//  DifficultyAdjustment
//
//  Created by Andriiko on 23.04.2023.
//

import Foundation

struct WorldStateDto: Encodable {
    let health: Double
    let healthToTime: Double
    let timeElapsed: Double
    let damagedLastWave: Double
    let avgWaveDamage: Double
    let factorDifference: Double
    let currentDifficulty: Double
}
