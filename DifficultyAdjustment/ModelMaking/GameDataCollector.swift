//
//  GameDataCollector.swift
//  DifficultyAdjustment
//
//  Created by Andriiko on 29.03.2023.
//

import Foundation
import os.log

final class GameDataCollector {
    
    private let fileName = "game_data.csv"
    
    func write(_ data: DataEntry) {
        let fileURL = getFileURL()
        let header = "health,health_to_time,damaged_last_wave,avg_wave_damage,factor_difference,agent_action,agent_reward\n"
        let row = data.toCSV() + "\n"
        
        let csvText = FileManager.default.fileExists(
            atPath: fileURL.path
        ) ? row : header.appending(row)
 
        do {
            try csvText.append(to: fileURL, encoding: .utf8)
        } catch {
            print("Error writing CSV file: \(error)")
        }
    }
    
    func read() -> [[String]]? {
        let fileURL = getFileURL()
        
        do {
            let contents = try String(contentsOf: fileURL, encoding: .utf8)
            let rows = contents.components(separatedBy: .newlines)
                .filter { !$0.isEmpty }
                .map { $0.components(separatedBy: ",") }
            return rows
        } catch {
            print("Error reading CSV file: \(error.localizedDescription)")
            return nil
        }
    }
    
    private func getFileURL() -> URL {
        let dirURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        return dirURL.appendingPathComponent(fileName)
    }
}
