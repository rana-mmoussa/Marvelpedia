//
//  CharactersListPresenterTests.swift
//  MarvelpediaTests
//
//  Created by Rana Moussa on 08/06/2022.
//

import XCTest
@testable import Marvelpedia

class CharactersListPresenterTests: XCTestCase {
    var repo = CharactersRepoMock()
    var view: CharacterListViewStub!
    var router: CharactersRouterStub!
    // sut
    var presenter: CharacterListPresenter!

    override func setUp() {
        view = CharacterListViewStub()
        router = CharactersRouterStub(viewController: nil)
        presenter = CharacterListPresenter(view: view, router: router, repo: repo)
    }

    override func tearDown() {
        view = nil
        router = nil
    }

    func testGetCharacters() {
        presenter.getCharacters(withName: "sample keyword")
        waitForxpectations()
        
        // assert that number of characters parsed from mock json is 10
        XCTAssertEqual(presenter.numberOfCharacters(), 10)
        
        // assert that cell model is created successfully
        let model = presenter.getCharacterDisplayModel(at: 5)
        XCTAssertEqual(model.character.name, "Abomination (Ultimate)")
        
        // assert that clear filters button is shown when we filter by name
        XCTAssertTrue(presenter.shouldShowClearButton)
    }
    
    func testGetCharactersViewDelegateBehavior() {
        presenter.getCharacters(withName: "sample keyword")
        waitForxpectations()
        
        // assert that reload data is called
        XCTAssertTrue(view.dataIsReloaded)
        
        // assert that loading is shown and hidden successfully
        XCTAssertTrue(view.loadingIsShown)
        XCTAssertTrue(view.loadingIsHidden)
        XCTAssertFalse(view.bottomLoadingIsShown)
        
        // assert that bottom loading is shown when we alrady have characters in the list
        presenter.getCharacters(withName: "sample keyword")
        waitForxpectations()
        
        XCTAssertTrue(view.bottomLoadingIsShown)
    }
    
    func testNavigationToCharacterDetails() {
        presenter.getCharacters(withName: "sample keyword")
        waitForxpectations()
        
        // assert that correct router method is called
        presenter.didSelectCharacter(at: 2)
        XCTAssertTrue(router.navigateToCharacterDetailsIsCalled)
    }
    
    private func waitForxpectations() {
        let expectation = self.expectation(description: "Test")
        DispatchQueue.main.async {
            expectation.fulfill()
        }
        self.waitForExpectations(timeout: 1, handler: nil)
    }
}
