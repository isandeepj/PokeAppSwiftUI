//
//  PokemonListViewModelTests.swift
//  PokeAppSwiftUITests
//
//  Created by Sandeep on 22/05/24.
//

import XCTest
import Combine

@testable import PokeAppSwiftUI

final class PokemonListViewModelTests: XCTestCase {
    var viewModel: PokemonListViewModel!
    var mockPokemonService: MockPokemonService!
    var cancellables: Set<AnyCancellable>!
    
    override func setUpWithError() throws {
        mockPokemonService = MockPokemonService()
        viewModel = PokemonListViewModel(pokemonService: mockPokemonService)
        cancellables = []
    }
    
    override func tearDownWithError() throws {
        viewModel = nil
        mockPokemonService = nil
        cancellables = nil
    }
    
    func testFetchPokemonList() {
        // Given
        let expectedPokemon = [
            PokemonSummary(id: UUID(uuidString: "00000000-0000-0000-0000-000000000001")!, name: "bulbasaur", url: "https://pokeapi.co/api/v2/pokemon/1/"),
            PokemonSummary(id: UUID(uuidString: "00000000-0000-0000-0000-000000000002")!, name: "ivysaur", url: "https://pokeapi.co/api/v2/pokemon/2/"),
            PokemonSummary(id: UUID(uuidString: "00000000-0000-0000-0000-000000000003")!, name: "venusaur", url: "https://pokeapi.co/api/v2/pokemon/3/")
        ]
        let response = PokemonListResponse(count: 3, next: nil, previous: nil, results: expectedPokemon)
        mockPokemonService.mockPokemonListResponse = response

        let expectation = XCTestExpectation(description: "Fetch Pokemon List")
        
        // When
        viewModel.fetchPokemon()
        viewModel.$pokemonList
            .dropFirst()
            .sink { pokemonList in
                if !pokemonList.isEmpty {
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)
        
        // Then
        wait(for: [expectation], timeout: 2.0)
        XCTAssertEqual(viewModel.pokemonList, expectedPokemon)
    }
    
    func testSortPokemonListByName() {
        // Given
        let unsortedPokemon = [
            PokemonSummary(id: UUID(uuidString: "00000000-0000-0000-0000-000000000002")!, name: "ivysaur", url: "https://pokeapi.co/api/v2/pokemon/2/"),
            PokemonSummary(id: UUID(uuidString: "00000000-0000-0000-0000-000000000003")!, name: "venusaur", url: "https://pokeapi.co/api/v2/pokemon/3/"),
            PokemonSummary(id: UUID(uuidString: "00000000-0000-0000-0000-000000000001")!, name: "bulbasaur", url: "https://pokeapi.co/api/v2/pokemon/1/")
        ]
        viewModel.pokemonList = unsortedPokemon
        viewModel.sortCriteria = .name
        
        // When
        viewModel.sortPokemonList()
        
        // Then
        let sortedPokemon = [
            PokemonSummary(id: UUID(uuidString: "00000000-0000-0000-0000-000000000001")!, name: "bulbasaur", url: "https://pokeapi.co/api/v2/pokemon/1/"),
            PokemonSummary(id: UUID(uuidString: "00000000-0000-0000-0000-000000000002")!, name: "ivysaur", url: "https://pokeapi.co/api/v2/pokemon/2/"),
            PokemonSummary(id: UUID(uuidString: "00000000-0000-0000-0000-000000000003")!, name: "venusaur", url: "https://pokeapi.co/api/v2/pokemon/3/")
        ]
        XCTAssertEqual(viewModel.pokemonList, sortedPokemon)
    }
    
    func testSortPokemonListById() {
        // Given
        let unsortedPokemon = [
            PokemonSummary(id: UUID(uuidString: "00000000-0000-0000-0000-000000000003")!, name: "venusaur", url: "https://pokeapi.co/api/v2/pokemon/3/"),
            PokemonSummary(id: UUID(uuidString: "00000000-0000-0000-0000-000000000001")!, name: "bulbasaur", url: "https://pokeapi.co/api/v2/pokemon/1/"),
            PokemonSummary(id: UUID(uuidString: "00000000-0000-0000-0000-000000000002")!, name: "ivysaur", url: "https://pokeapi.co/api/v2/pokemon/2/")
        ]
        viewModel.pokemonList = unsortedPokemon
        viewModel.sortCriteria = .id
        
        // When
        viewModel.sortPokemonList()
        
        // Then
        let sortedPokemon = [
            PokemonSummary(id: UUID(uuidString: "00000000-0000-0000-0000-000000000001")!, name: "bulbasaur", url: "https://pokeapi.co/api/v2/pokemon/1/"),
            PokemonSummary(id: UUID(uuidString: "00000000-0000-0000-0000-000000000002")!, name: "ivysaur", url: "https://pokeapi.co/api/v2/pokemon/2/"),
            PokemonSummary(id: UUID(uuidString: "00000000-0000-0000-0000-000000000003")!, name: "venusaur", url: "https://pokeapi.co/api/v2/pokemon/3/")
        ]
        XCTAssertEqual(viewModel.pokemonList, sortedPokemon)
    }
}

class MockPokemonService: PokemonListService {
    var mockPokemonListResponse: PokemonListResponse?
    
    func fetchPokemon() -> AnyPublisher<PokemonListResponse, Error> {
        if let response = mockPokemonListResponse {
            return Just(response)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        } else {
            return Fail(error: URLError(.badURL))
                .eraseToAnyPublisher()
        }
    }
}
