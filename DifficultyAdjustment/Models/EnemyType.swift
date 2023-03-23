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
    
    // Value in range 0...1 that shows how hard the enemy is to deal with.
    var difficulty: CGFloat {
        switch self {
        case .justEnemy:
            return 0.1
        case .chasing:
            return 0.5
        }
    }
    
    var random: Self {
        Self.allCases.randomElement()!
    }
}
