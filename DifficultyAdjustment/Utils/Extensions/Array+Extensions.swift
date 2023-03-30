//
//  Array+Extensions.swift
//  DifficultyAdjustment
//
//  Created by Andriiko on 30.03.2023.
//

import Foundation

extension Array where Element: BinaryFloatingPoint {
    func average() -> Element {
        isEmpty ? .zero : reduce(.zero, +) / Element(count)
    }
}
