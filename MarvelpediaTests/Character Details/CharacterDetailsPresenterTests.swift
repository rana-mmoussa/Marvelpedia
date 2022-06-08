//
//  CharacterDetailsPresenterTests.swift
//  MarvelpediaTests
//
//  Created by Rana Moussa on 08/06/2022.
//

import XCTest
@testable import Marvelpedia

class CharacterDetailsPresenterTests: XCTestCase {
    var repo = CharactersRepoMock()
    var view: CharacterDetailsViewStub!
    var router: CharactersRouterStub!
    // sut
    var presenter: CharacterDetailsPresenter!

    override func setUp() {
        view = CharacterDetailsViewStub()
        router = CharactersRouterStub(viewController: nil)
        presenter = CharacterDetailsPresenter(view: view, router: router, repo: repo)
    }

    override func tearDown() {
        view = nil
        router = nil
    }

    func testGetCharacter() throws {
        presenter.getCharacter(with: 123456)
        waitForxpectations()
        
        // assert that character details are fetched correctly
        XCTAssertTrue(view.didDisplayCharacter)
        XCTAssertEqual(view.character?.name ?? "", "3-D Man")
        
        // assert content details
        XCTAssertEqual(view.character?.comics?.available ?? 0, 12)
        XCTAssertEqual(view.character?.series?.available ?? 0, 3)
        XCTAssertEqual(view.character?.stories?.available ?? 0, 21)
    }
    
    func testGetCharacterDetailsDelegateBehavior() {
        presenter.getCharacter(with: 123456)
        waitForxpectations()
        
        // assert that loading is shown and hidden successfully
        XCTAssertTrue(view.loadingIsShown)
        XCTAssertTrue(view.loadingIsHidden)
    }
    
    func testNavigationToComicsContentSheet() {
        presenter.getCharacter(with: 123456)
        waitForxpectations()
        
        // assert that sheet is shown with the correct data mapping
        presenter.comicsButtonClicked()
        XCTAssertTrue(router.presentCharacterContentIsCalled)
        XCTAssertEqual(router.content?.type, CharacterContentType.comics)
        XCTAssertEqual(router.content?.count ?? 0, 12)
        XCTAssertEqual(router.content?.titles.count ?? 0, 12)
    }
    
    func testNavigationToSeriesContentSheet() {
        presenter.getCharacter(with: 123456)
        waitForxpectations()
        
        // assert that sheet is shown with the correct data mapping
        presenter.seriesButtonClicked()
        XCTAssertTrue(router.presentCharacterContentIsCalled)
        XCTAssertEqual(router.content?.type, CharacterContentType.series)
        XCTAssertEqual(router.content?.count ?? 0, 3)
        XCTAssertEqual(router.content?.titles.count ?? 0, 3)
    }
    
    func testNavigationToStoriesContentSheet() {
        presenter.getCharacter(with: 123456)
        waitForxpectations()
        
        // assert that sheet is shown with the correct data mapping
        presenter.storiesButtonClicked()
        XCTAssertTrue(router.presentCharacterContentIsCalled)
        XCTAssertEqual(router.content?.type, CharacterContentType.stories)
        XCTAssertEqual(router.content?.count ?? 0, 21)
        XCTAssertEqual(router.content?.titles.count ?? 0, 20)
    }
    
    private func waitForxpectations() {
        let expectation = self.expectation(description: "Test")
        DispatchQueue.main.async {
            expectation.fulfill()
        }
        self.waitForExpectations(timeout: 1, handler: nil)
    }

}
