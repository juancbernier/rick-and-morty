//
//  Character.swift
//  RickAndMorty
//
//  Created by Juan Bernier on 1/01/26.
//

import Foundation

struct Character: Identifiable, Codable, Equatable, Hashable {
    let id: Int
    let name: String
    let status: CharacterStatus
    let species: String
    let type: String
    let gender: String
    let origin: Location
    let location: Location
    let image: String
    let episode: [String]
    let url: String
    let created: String
    
    struct Location: Codable, Equatable, Hashable {
        let name: String
        let url: String
    }
    
    enum CharacterStatus: String, Codable, CaseIterable, Hashable {
        case alive = "Alive"
        case dead = "Dead"
        case unknown = "unknown"
        
        var displayName: String {
            switch self {
            case .alive: return "Alive"
            case .dead: return "Dead"
            case .unknown: return "Unknown"
            }
        }
        
        static var allCasesForFilter: [CharacterStatus?] {
            [nil] + CharacterStatus.allCases
        }
        
        static func filterDisplayName(_ status: CharacterStatus?) -> String {
            status?.displayName ?? "All"
        }
    }
}
