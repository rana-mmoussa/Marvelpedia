//
//  CharacterDetailsPresenter.swift
//  Marvelpedia
//
//  Created by Rana Moussa on 07/06/2022.
//

import Foundation
import RxSwift

protocol CharacterDetailsPresenterDelegate {
    func getCharacter(with id: Double)
    func comicsButtonClicked()
    func seriesButtonClicked()
    func storiesButtonClicked()
}

class CharacterDetailsPresenter: CharacterDetailsPresenterDelegate {
    private weak var view: CharacterDetailsViewControllerDelegate?
    private var router: CharactersRouterProtocol
    private var repo: CharacterRepositoryProtocol
    
    private var character: MarvelCharacter?
    
    private var disposeBag = DisposeBag()
    
    init(view: CharacterDetailsViewControllerDelegate,
         router: CharactersRouterProtocol,
         repo: CharacterRepositoryProtocol) {
        self.view = view
        self.router = router
        self.repo = repo
    }
    
    func getCharacter(with id: Double) {
        let observable = repo.getCharacterDetails(withId: id)
        observable.subscribe(onNext: { [weak self] response in
            self?.getCharacterDetailsSucceeded(response: response)
            
        }, onError: { error in
            // TODO: error handling
            print(error.localizedDescription)
            
        }).disposed(by: disposeBag)
    }
    
    func comicsButtonClicked() {
        if let comics = character?.comics?.items, !comics.isEmpty {
            let content = comics.map {
                ($0.name ?? "No Name", $0.resourceURI?.absoluteString ?? "")
            }
            router.presentCharacterContent(CharacterContent(type: .comics,
                                                            count: character?.comics?.available ?? 0,
                                                            content: content))
        }
    }
    
    func seriesButtonClicked() {
        if let series = character?.series?.items, !series.isEmpty {
            let content = series.map {
                ($0.name ?? "No Name", $0.resourceURI?.absoluteString ?? "")
            }
            router.presentCharacterContent(CharacterContent(type: .series,
                                                            count: character?.series?.available ?? 0,
                                                            content: content))
        }
    }
    
    func storiesButtonClicked() {
        if let stories = character?.stories?.items, !stories.isEmpty {
            let content = stories.map {
                ($0.name ?? "No Name", $0.resourceURI?.absoluteString ?? "")
            }
            router.presentCharacterContent(CharacterContent(type: .stories,
                                                            count: character?.stories?.available ?? 0,
                                                            content: content))
        }
    }
    
    // MARK: private
    func getCharacterDetailsSucceeded(response: GetCharacterResponse) {
        if let character = response.data?.results?.first {
            self.character = character
            DispatchQueue.main.async { [weak self] in
                self?.view?.displayCharacter(character)
            }
        }
    }
}
    
