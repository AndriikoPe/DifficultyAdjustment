//
//  GameStateDelegate.swift
//  DifficultyAdjustment
//
//  Created by Andriiko on 26.03.2023.
//

import Foundation

protocol GameStateDelegate: AnyObject {
    func end(with time: TimeInterval)
    func updateDifficulty(_ difficulty: CGFloat)
}
