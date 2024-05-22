//
//  PokemonListResponse.swift
//  PokeAppSwiftUI
//
//  Created by Sandeep on 22/05/24.
//

import Foundation

import Foundation

struct PokemonSummary: Identifiable, Codable, Equatable {
    let id: UUID
    let name: String
    let url: String
    
    // Custom initializer for setting the UUID (useful for testing)
    init(id: UUID = UUID(), name: String, url: String) {
        self.id = id
        self.name = name
        self.url = url
    }
    
    // Custom initializer for decoding
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = UUID() // Generates a new UUID for each decoded instance
        self.name = try container.decode(String.self, forKey: .name)
        self.url = try container.decode(String.self, forKey: .url)
    }
    
    // Encoding function
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(url, forKey: .url)
    }
    
    private enum CodingKeys: String, CodingKey {
        case name
        case url
    }
}

// Extension to extract ID from URL
extension PokemonSummary {
    var idFromURL: Int {
        return Int(url.split(separator: "/").last ?? "0") ?? 0
    }
}
struct PokemonListResponse: Codable {
    let count: Int
    let next: String?
    let previous: String?
    let results: [PokemonSummary]
}
