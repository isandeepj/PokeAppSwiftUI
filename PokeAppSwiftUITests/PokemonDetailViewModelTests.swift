//
//  PokemonDetailViewModelTests.swift
//  PokeAppSwiftUITests
//
//  Created by Sandeep on 22/05/24.
//

import XCTest
@testable import PokeAppSwiftUI

final class PokemonDetailViewModelTests: XCTestCase {
    var viewModel: PokemonDetailViewModel!
    var mockURLSession: MockURLSession!

    override func setUpWithError() throws {
        mockURLSession = MockURLSession()
        viewModel = PokemonDetailViewModel()
    }
 
    override func tearDownWithError() throws {
        viewModel = nil
        mockURLSession = nil
    }

    func testFetchDetailsSuccess() {
        // Given
        let jsonData = """
            {
                "id": 1,
                "name": "bulbasaur",
                "base_experience": 64,
                "height": 7,
                "weight": 69,
                "abilities": [
                    {
                        "ability": { "name": "overgrow", "url": "" },
                        "is_hidden": false,
                        "slot": 1
                    }
                ],
                "sprites": {
                    "front_default": "https://example.com/image.png"
                },
                "stats": [
                    { "base_stat": 45, "effort": 0, "stat": { "name": "hp", "url": "" } }
                ],
                "types": [
                    { "slot": 1, "type": { "name": "grass", "url": "" } }
                ],
                "cries": { "latest": "", "legacy": "" }
            }
            """.data(using: .utf8)!
        
        mockURLSession.data = jsonData
        
        // When
        let expectation = self.expectation(description: "Fetch details")
        viewModel.fetchDetails(for: "https://example.com/pokemon/1")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            expectation.fulfill()
        }
        waitForExpectations(timeout: 2, handler: nil)
        
        // Then
        XCTAssertNotNil(viewModel.pokemonDetail)
        XCTAssertEqual(viewModel.pokemonDetail?.name, "bulbasaur")
    }
    
    func testFetchDetailsFailure() {
        // Given
        mockURLSession.error = NSError(domain: "Test", code: 1, userInfo: nil)
        
        // When
        let expectation = self.expectation(description: "Fetch details")
        viewModel.fetchDetails(for: "https://example.com/pokemon/1")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            expectation.fulfill()
        }
        waitForExpectations(timeout: 2, handler: nil)
        
        // Then
        XCTAssertNil(viewModel.pokemonDetail)
        XCTAssertNotNil(viewModel.errorMessage)
    }

}
class MockURLSession {
    var data: Data?
    var error: Error?

    func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        completionHandler(data, nil, error)
        return URLSession.shared.dataTask(with: url)
    }
}
