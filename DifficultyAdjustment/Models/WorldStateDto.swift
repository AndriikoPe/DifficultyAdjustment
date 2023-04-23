//
//  WorldStateDto.swift
//  DifficultyAdjustment
//
//  Created by Andriiko on 23.04.2023.
//

import Foundation

struct WorldStateDto: Encodable {
    let health: CGFloat
    let healthToTime: CGFloat
    let timeElapsed: CGFloat
    let damagedLastWave: CGFloat
    let avgWaveDamage: CGFloat
    let factorDifference: CGFloat
    let currentDifficulty: CGFloat
}
