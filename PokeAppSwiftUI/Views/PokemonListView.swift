//
//  PokemonListView.swift
//  PokeAppSwiftUI
//
//  Created by Sandeep on 22/05/24.
//

import SwiftUI

struct PokemonListView: View {
    @StateObject private var viewModel: PokemonListViewModel

    init(viewModel: PokemonListViewModel = PokemonListViewModel(pokemonService: PokemonService())) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    var body: some View {
        NavigationView {
            List(viewModel.pokemonList) { pokemon in
                NavigationLink(destination: PokemonDetailView(pokemon: pokemon)) {
                    Text(pokemon.name.capitalized)
                        .accessibilityIdentifier("PokemonName")  // Add accessibility identifier
                        .onAppear {
                            viewModel.loadMorePokemon(currentItem: pokemon)
                        }

                    
                }
            }
            .accessibilityIdentifier("PokemonList")  // Add accessibility identifier
            .listStyle(PlainListStyle())
            .navigationTitle("Pokemon")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Picker("Sort by", selection: $viewModel.sortCriteria) {
                        Text("ID").tag(SortCriteria.id)
                        Text("Name").tag(SortCriteria.name)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .onChange(of: viewModel.sortCriteria) { _ in
                        viewModel.sortPokemonList()
                    }
                }
            }
        }.onAppear {
            viewModel.fetchPokemon()
        }
    }
}

struct PokemonListView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonListView()
    }
}
