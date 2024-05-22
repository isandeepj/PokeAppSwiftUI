//
//  PokemonService.swift
//  PokeAppSwiftUI
//
//  Created by Sandeep on 22/05/24.
//

import Foundation
import Combine

protocol PokemonListService {
    func fetchPokemon() -> AnyPublisher<PokemonListResponse, Error>
}

class PokemonService: PokemonListService {
    private var nextURL: String = "https://pokeapi.co/api/v2/pokemon?limit=100"

    func fetchPokemon() -> AnyPublisher<PokemonListResponse, Error> {
        guard let url = URL(string: nextURL) else {
            return Fail(error: URLError(.badURL))
                .eraseToAnyPublisher()
        }

        return URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: PokemonListResponse.self, decoder: JSONDecoder())
            .map { [weak self] response -> PokemonListResponse in
                self?.nextURL = response.next ?? ""
                return response
            }
            .eraseToAnyPublisher()
    }
}
