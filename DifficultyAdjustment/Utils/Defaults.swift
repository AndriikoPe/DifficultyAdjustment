//
//  Defaults.swift
//  DifficultyAdjustment
//
//  Created by Andriiko on 23.04.2023.
//

import Foundation

enum Defaults {
    private enum Keys {
        static let agent = "agent"
    }
    
    static var agent: AppConstants.Regulator {
        get {
            .init(rawValue: UserDefaults.standard.integer(forKey: Keys.agent))!
        }
        set {
            UserDefaults.standard.set(newValue.rawValue, forKey: Keys.agent)
        }
    }
}
