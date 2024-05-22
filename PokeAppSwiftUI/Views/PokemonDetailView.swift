//
//  PokemonDetailView.swift
//  PokeAppSwiftUI
//
//  Created by Sandeep on 22/05/24.
//

import SwiftUI

struct PokemonDetailView: View {
    let pokemon: PokemonSummary
    @StateObject private var viewModel = PokemonDetailViewModel()

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                if let detail = viewModel.pokemonDetail {
                    PokemonHeaderView(pokemon: detail)
                    PokemonInfoView(detail: detail)
                } else if let errorMessage = viewModel.errorMessage {
                    Text("Error: \(errorMessage)")
                        .foregroundColor(.red)
                } else {
                    Text("Loading...")
                }
            }
            .padding()
        }
        .accessibilityIdentifier("PokemonDetailView")  // Add accessibility identifier
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            viewModel.fetchDetails(for: pokemon.url)
        }
    }
}

struct PokemonDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonDetailView(pokemon: mockPokemonSummary)
            .environmentObject(MockPokemonDetailViewModel())
    }
}

// Mock data for preview
let mockPokemonSummary = PokemonSummary(
    name: "bulbasaur",
    url: "https://pokeapi.co/api/v2/pokemon/1/"
)

let mockPokemonDetail = Pokemon(
    id: 1,
    name: "bulbasaur",
    base_experience: 64,
    height: 7,
    weight: 69,
    abilities: [
        Pokemon.Ability(ability: Pokemon.NameURL(name: "overgrow", url: ""), is_hidden: false, slot: 1),
        Pokemon.Ability(ability: Pokemon.NameURL(name: "chlorophyll", url: ""), is_hidden: true, slot: 3)
    ],
    sprites: Pokemon.Sprites(
        front_default: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png",
        back_default: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/1.png",
        front_shiny: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/1.png",
        back_shiny: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/shiny/1.png",
        other: nil
    ),
    stats: [
        Pokemon.Stat(base_stat: 45, effort: 0, stat: Pokemon.NameURL(name: "hp", url: "")),
        Pokemon.Stat(base_stat: 49, effort: 0, stat: Pokemon.NameURL(name: "attack", url: "")),
        Pokemon.Stat(base_stat: 49, effort: 0, stat: Pokemon.NameURL(name: "defense", url: "")),
        Pokemon.Stat(base_stat: 65, effort: 1, stat: Pokemon.NameURL(name: "special-attack", url: "")),
        Pokemon.Stat(base_stat: 65, effort: 0, stat: Pokemon.NameURL(name: "special-defense", url: "")),
        Pokemon.Stat(base_stat: 45, effort: 0, stat: Pokemon.NameURL(name: "speed", url: ""))
    ],
    types: [
        Pokemon.TypeElement(slot: 1, type: Pokemon.NameURL(name: "grass", url: "")),
        Pokemon.TypeElement(slot: 2, type: Pokemon.NameURL(name: "poison", url: ""))
    ],
    cries: Pokemon.Cries(latest: "", legacy: "")
)

class MockPokemonDetailViewModel: PokemonDetailViewModel {
    override init() {
        super.init()
        self.pokemonDetail = mockPokemonDetail
    }
}
