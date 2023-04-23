//
//  RealAgent.swift
//  DifficultyAdjustment
//
//  Created by Andriiko on 22.04.2023.
//

import Foundation

final class RealAgent {
    private let fileUrl = Bundle.main.url(forResource: "UrlFile", withExtension: nil)!
    
    func getAction(for state: WorldState) async throws -> Double {
        guard let urlString = try? String(
            contentsOf: fileUrl, encoding: .utf8
        ).trimmingCharacters(in: .whitespacesAndNewlines),
              let url = URL(string: urlString)
        else { return 0.0 }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let jsonData = try JSONEncoder().encode(HttpBody(data: state))
        request.httpBody = jsonData
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let (data, _) = try await URLSession.shared.data(for: request)
        
        let responseDict = try JSONDecoder().decode([String: Double].self, from: data)
        
        guard let action = responseDict["action"] else {
            throw NSError(domain: "Invalid response", code: 0, userInfo: nil)
        }
        
        return action
    }
    
    private struct HttpBody: Encodable {
        let data: WorldState
    }
}
