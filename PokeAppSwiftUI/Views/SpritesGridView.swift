//
//  SpritesGridView.swift
//  PokeAppSwiftUI
//
//  Created by Sandeep on 22/05/24.
//

import SwiftUI

struct SpritesGridView: View {
    let sprites: Pokemon.Sprites

    var body: some View {
        let columns = [GridItem(.flexible()), GridItem(.flexible())]
        LazyVGrid(columns: columns, spacing: 0) {
            if let frontDefault = sprites.front_default, let url = URL(string: frontDefault) {
                AsyncImageView(url: url)
                    .frame(width: 100, height: 100)
            }

            if let backDefault = sprites.back_default, let url = URL(string: backDefault) {
                AsyncImageView(url: url)
                    .frame(width: 100, height: 100)
            }

            if let frontShiny = sprites.front_shiny, let url = URL(string: frontShiny) {
                AsyncImageView(url: url)
                    .frame(width: 100, height: 100)
            }

            if let backShiny = sprites.back_shiny, let url = URL(string: backShiny) {
                AsyncImageView(url: url)
                    .frame(width: 100, height: 100)
            }
        }
    }
}

struct SpritesGridView_Previews: PreviewProvider {
    static var previews: some View {
        SpritesGridView(sprites: mockPokemonDetail.sprites)
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
