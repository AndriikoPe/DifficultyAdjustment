//
//  String+Extensions.swift
//  DifficultyAdjustment
//
//  Created by Andriiko on 29.03.2023.
//

import Foundation

extension String {
    func append(to url: URL, encoding: String.Encoding) throws {
        let data = self.data(using: encoding)!
        if let fileHandle = FileHandle(forWritingAtPath: url.path) {
            defer {
                fileHandle.closeFile()
            }
            fileHandle.seekToEndOfFile()
            fileHandle.write(data)
        } else {
            try write(to: url, atomically: true, encoding: encoding)
        }
    }
}
