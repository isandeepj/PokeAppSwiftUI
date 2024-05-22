//
//  PokemonListViewUIUITests.swift
//  PokeAppSwiftUIUITests
//
//  Created by Sandeep on 22/05/24.
//

import XCTest

final class PokemonListViewUIUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        XCUIApplication().launch()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testListContainsPokemon() throws {
        let app = XCUIApplication()
        let collectionView = app.collectionViews["PokemonList"]
        
        // Wait for the table to appear
        let exists = NSPredicate(format: "exists == true")
        expectation(for: exists, evaluatedWith: collectionView, handler: nil)
        waitForExpectations(timeout: 10, handler: nil)
        
        // Check if the table has any cells (assuming data is loaded)
        XCTAssertGreaterThan(collectionView.cells.count, 0)
        
        // Check if the first cell contains a Pokemon name (you can adjust the identifier)
        let firstCell = collectionView.cells.element(boundBy: 0)
        XCTAssert(firstCell.staticTexts["PokemonName"].exists)
    }
    
    func testNavigationToDetailView() throws {
        let app = XCUIApplication()
        let collectionView = app.collectionViews["PokemonList"]
        
        // Wait for the table to appear
        let exists = NSPredicate(format: "exists == true")
        expectation(for: exists, evaluatedWith: collectionView, handler: nil)
        waitForExpectations(timeout: 10, handler: nil)
        
        // Tap the first cell
        let firstCell = collectionView.cells.element(boundBy: 0)
        firstCell.tap()
        
        // Check if the detail view is displayed (you can adjust the identifier)
        let detailView = app.scrollViews["PokemonDetailView"]
        XCTAssert(detailView.exists)
    }
}
