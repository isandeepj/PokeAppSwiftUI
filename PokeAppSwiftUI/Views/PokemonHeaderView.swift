//
//  PokemonHeaderView.swift
//  PokeAppSwiftUI
//
//  Created by Sandeep on 22/05/24.
//

import SwiftUI

struct PokemonHeaderView: View {
    let pokemon: Pokemon

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(pokemon.name.capitalized)
                .font(.largeTitle)
                .padding(.bottom, 10)
            Text("ID: \(pokemon.id)")
            Text("Base Experience: \(pokemon.base_experience)")
            Text("Height: \(pokemon.height)")
            Text("Weight: \(pokemon.weight)")
        }
    }
}

struct PokemonHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonHeaderView(pokemon: mockPokemonDetail)
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
