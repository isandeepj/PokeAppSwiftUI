//
//  PokemonDetailViewModel.swift
//  PokeAppSwiftUI
//
//  Created by Sandeep on 22/05/24.
//

import SwiftUI
import Combine

class PokemonDetailViewModel: ObservableObject {
    @Published var pokemonDetail: Pokemon?
    @Published var errorMessage: String?

    private var cancellable: AnyCancellable?

    func fetchDetails(for url: String) {
        guard let detailURL = URL(string: url) else { return }

        cancellable = URLSession.shared.dataTaskPublisher(for: detailURL)
            .map { $0.data }
            .decode(type: Pokemon.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { completion in
                    switch completion {
                    case .failure(let error):
                        self.errorMessage = error.localizedDescription
                    case .finished:
                        break
                    }
                },
                receiveValue: { [weak self] pokemon in
                    self?.pokemonDetail = pokemon
                }
            )
    }
}

