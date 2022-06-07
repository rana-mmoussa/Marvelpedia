//
//  CharacterListPresenter.swift
//  Marvelpedia
//
//  Created by Rana Moussa on 06/06/2022.
//

import Foundation
import RxSwift

protocol CharacterListPresenterDelegate: AnyObject {
    var shouldShowClearButton: Bool { get }
    func getCharacters(withName name: String?)
    func numberOfCharacters() -> Int
    func getCharacterDisplayModel(at index: Int) -> MarvelCharacterCellModel
    func shouldLoadMore(after index: Int) -> Bool
    func resetParams()
    func didSelectCharacter(at index: Int)
    func getRowHeight(for height: CGFloat) -> CGFloat
}

class CharacterListPresenter: CharacterListPresenterDelegate {
    private weak var view: CharacterListViewControllerDelegate?
    private var router: CharactersRouterProtocol
    private var repo: CharacterRepositoryProtocol
    
    private var characters: [MarvelCharacter] = []
    private var offset = 0
    private let pageCount = 10
    private var currentKeyword: String?
    
    private var disposeBag = DisposeBag()
    
    init(view: CharacterListViewControllerDelegate,
         router: CharactersRouterProtocol,
         repo: CharacterRepositoryProtocol) {
        self.view = view
        self.router = router
        self.repo = repo
    }
    
    // MARK: CharacterListViewModelDelegate
    
    var shouldShowClearButton: Bool {
        if let currentKeyword = currentKeyword {
            return !currentKeyword.isEmpty
        }
        return false
    }
    
    func numberOfCharacters() -> Int {
        return characters.count
    }
    
    func getCharacters(withName name: String?) {
        showLoading()
        let params = GetCharactersRequest.Params(offset: offset, limit: pageCount,
                                                 nameStartsWith: name)
        let observable = repo.getCharactersList(params: params)
        observable.subscribe(onNext: { [weak self] response in
            self?.checkNeedsReset(keyword: name)
            self?.getCharactersSucceeded(response: response)
            
        }, onError: { error in
            // TODO: error handling
            print(error.localizedDescription)
            
        }).disposed(by: disposeBag)
    }
    
    func getCharacterDisplayModel(at index: Int) -> MarvelCharacterCellModel {
        let character = characters[index]
        let uiModel = CharacterUIModel(imageUrl: character.thumbnail?.url,
                                       name: character.name ?? "No Name",
                                       description: character.resultDescription ?? "No Description")
        return MarvelCharacterCellModel(character: uiModel, isMirrored: index % 2 == 0)
    }
    
    func shouldLoadMore(after index: Int) -> Bool {
        return index == (characters.count - 1)
    }
    
    func resetParams() {
        characters = []
        offset = 0
        currentKeyword = nil
    }
    
    func didSelectCharacter(at index: Int) {
        router.navigateToCharacterDetailsPage(character: characters[index])
    }
    
    func getRowHeight(for height: CGFloat) -> CGFloat {
        return height / 5
    }
    
    // MARK: Private
    
    private func showLoading() {
        if characters.isEmpty {
            view?.showLoading()
        } else {
            view?.showBottomLoadingIndicator()
        }
    }
    
    private func checkNeedsReset(keyword: String?) {
        if keyword != currentKeyword {
            resetParams()
            currentKeyword = keyword
        }
    }
    
    private func getCharactersSucceeded(response: GetCharactersListResponse) {
        view?.hideLoading()
        if let newCharacters = response.data?.results, !newCharacters.isEmpty {
            characters.append(contentsOf: newCharacters)
            offset += newCharacters.count
            DispatchQueue.main.async { [weak self] in
                self?.view?.reloadData()
            }
        }
    }
}