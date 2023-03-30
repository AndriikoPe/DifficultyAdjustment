//
//  AppConstants.swift
//  DifficultyAdjustment
//
//  Created by Andriiko on 13.03.2023.
//

import UIKit

enum AppConstants {
    static let sceneSize = CGSize(width: 2340.0, height: 1080.0)
    static let targetPlayTime: TimeInterval = 60.0 * 3.0
    
    /// Modify this properpty to make game easier of harder.
    static var gameDifficultyKnob = 1.0
}
