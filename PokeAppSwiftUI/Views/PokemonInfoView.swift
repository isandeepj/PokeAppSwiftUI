//
//  PokemonInfoView.swift
//  PokeAppSwiftUI
//
//  Created by Sandeep on 22/05/24.
//

import SwiftUI

struct PokemonInfoView: View {
    let detail: Pokemon

    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            if !detail.abilities.isEmpty {
                SectionView(title: "Abilities") {
                    ForEach(detail.abilities, id: \.ability.name) { ability in
                        Text("\(ability.ability.name.capitalized) \(ability.is_hidden ? "(Hidden)" : "")")
                    }
                }
            }

            if !detail.types.isEmpty {
                SectionView(title: "Types") {
                    ForEach(detail.types, id: \.type.name) { type in
                        Text(type.type.name.capitalized)
                    }
                }
            }

            if !detail.stats.isEmpty {
                SectionView(title: "Stats") {
                    ForEach(detail.stats, id: \.stat.name) { stat in
                        Text("\(stat.stat.name.capitalized): \(stat.base_stat)")
                    }
                }
            }

            if hasSprites(detail.sprites) {
                SectionView(title: "Sprites") {
                    SpritesGridView(sprites: detail.sprites)
                }
            }
        }
    }

    private func hasSprites(_ sprites: Pokemon.Sprites) -> Bool {
        return sprites.front_default != nil ||
               sprites.back_default != nil ||
               sprites.front_shiny != nil ||
               sprites.back_shiny != nil
    }
}
struct PokemonInfoView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonInfoView(detail: mockPokemonDetail)
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
