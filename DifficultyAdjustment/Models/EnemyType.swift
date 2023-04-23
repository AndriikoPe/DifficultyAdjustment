//
//  EnemyType.swift
//  DifficultyAdjustment
//
//  Created by Andriiko on 23.03.2023.
//

import Foundation

enum EnemyType: CaseIterable {
    case justEnemy
    case chasing
    case tank
    case cannon
    
    static var random: Self {
        allCases.randomElement()!
    }
}
