//
//  WaveMaker.swift
//  DifficultyAdjustment
//
//  Created by Andriiko on 23.03.2023.
//

import UIKit

typealias Wave = [WavePiece]

final class WaveMaker {
    private let positions: [(CGPoint, CGFloat)] = [
        (CGPoint(x: -110.0, y: 590.0), -0.05 * .pi),
        (CGPoint(x: 1220.0, y: 0.0), 0.5 * .pi),
        (CGPoint(x: 2440.0, y: 590.0), 0.95 * .pi),
        (CGPoint(x: 2440.0, y: 1180.0), 1.1 * .pi),
        (CGPoint(x: 1220.0, y: 1180.0), -0.65 * .pi),
        (CGPoint(x: 0.0, y: 590.0), 0.04 * .pi),
        (CGPoint(x: 0.0, y: 0.0), 0.25 * .pi),
        (CGPoint(x: 2440.0, y: 590.0), 0.95 * .pi)
    ]

    func makeWave() -> Wave {
        positions.map {
            WavePiece(
                position: $0.0, direction: $0.1,
                enemyType: .random,
                delay: TimeInterval.random(in: 0...15))
        }
    }
}
