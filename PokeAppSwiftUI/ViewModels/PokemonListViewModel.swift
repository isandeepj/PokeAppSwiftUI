//
//  PokemonListViewModel.swift
//  PokeAppSwiftUI
//
//  Created by Sandeep on 22/05/24.
//

import Foundation
import SwiftUI
import Combine

enum SortCriteria: String, CaseIterable, Identifiable {
    case id, name
    var id: String { self.rawValue }
}
class PokemonListViewModel: ObservableObject {
    @Published var pokemonList: [PokemonSummary] = []
    @Published var sortCriteria: SortCriteria = .id
    private let pokemonService: PokemonListService
    private var cancellable: AnyCancellable?
    private var isLoading = false

    init(pokemonService: PokemonListService) {
        self.pokemonService = pokemonService
    }

    func fetchPokemon() {
        guard !isLoading else { return }
        
        isLoading = true
        
        cancellable = pokemonService.fetchPokemon()
            .map { response -> [PokemonSummary] in
                return response.results
            }
            .replaceError(with: [])
            .receive(on: DispatchQueue.main)
            .sink { [weak self] newPokemon in
                self?.pokemonList.append(contentsOf: newPokemon)
                self?.isLoading = false
                self?.sortPokemonList()
            }
    }

    func sortPokemonList() {
        switch sortCriteria {
        case .id:
            pokemonList.sort { $0.idFromURL < $1.idFromURL }
        case .name:
            pokemonList.sort { $0.name < $1.name }
        }
    }

    func loadMorePokemon(currentItem: PokemonSummary) {
        guard !isLoading else { return }
        
        let thresholdIndex = pokemonList.index(pokemonList.endIndex, offsetBy: -2)
        if let thresholdItem = pokemonList[safe: thresholdIndex], currentItem.id == thresholdItem.id {
            fetchPokemon()
        }
    }
}

// Safe array index access extension
extension Collection {
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}


class MockPokemonService: PokemonService {
    var mockPokemonList: [PokemonSummary] = []
    
    func fetchPokemonList() -> AnyPublisher<[PokemonSummary], Never> {
        return Just(mockPokemonList)
            .eraseToAnyPublisher()
    }
}
