//
//  Pokemon.swift
//  PokeAppSwiftUI
//
//  Created by Sandeep on 22/05/24.
//

import Foundation

struct Pokemon: Codable {
    let id: Int
    let name: String
    let base_experience: Int
    let height: Int
    let weight: Int
    let abilities: [Ability]
    let sprites: Sprites
    let stats: [Stat]
    let types: [TypeElement]
    let cries: Cries

    struct Ability: Codable {
        let ability: NameURL
        let is_hidden: Bool
        let slot: Int
    }

    struct NameURL: Codable {
        let name: String
        let url: String
    }

    struct Sprites: Codable {
        let front_default: String?
        let back_default: String?
        let front_shiny: String?
        let back_shiny: String?
        let other: OtherSprites?
    }

    struct OtherSprites: Codable {
        let dream_world: SpriteImage?
        let home: SpriteImage?
        let official_artwork: SpriteImage?
    }

    struct SpriteImage: Codable {
        let front_default: String?
    }

    struct Stat: Codable {
        let base_stat: Int
        let effort: Int
        let stat: NameURL
    }

    struct TypeElement: Codable {
        let slot: Int
        let type: NameURL
    }

    struct Cries: Codable {
        let latest: String
        let legacy: String
    }
}
