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
        (CGPoint(x: 1110.0, y: 510.0), 0.41102983491351734),
        (CGPoint(x: 1626.0, y: 929.0), 1.0778329381678084),
        (CGPoint(x: 1963.0, y: 645.0), 1.9356426571532643),
        (CGPoint(x: 1844.0, y: 266.0), 2.8478541427971925),
        (CGPoint(x: 1395.0, y: 266.0), 3.735249607743176),
        (CGPoint(x: 1126.0, y: 645.0), 4.593059326728632),
        (CGPoint(x: 1463.0, y: 929.0), 5.504270812372561),
        (CGPoint(x: 2340.0, y: 540.0), -0.12511003572113203),
        (CGPoint(x: 2173.0, y: 150.0), -0.9788415734231699),
        (CGPoint(x: 1715.0, y: 150.0), -1.8366512924086258)
    ]

    func makeWave() -> Wave {
        
        
        return []
    }
}
