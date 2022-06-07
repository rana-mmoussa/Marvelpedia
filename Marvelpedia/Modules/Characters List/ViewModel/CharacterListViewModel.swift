//
//  CharacterListViewModel.swift
//  Marvelpedia
//
//  Created by Rana Moussa on 06/06/2022.
//

import Foundation
import RxSwift

protocol CharacterListViewModelDelegate: AnyObject {
    var shouldShowClearButton: Bool { get }
    func getCharacters(withName name: String?)
    func numberOfCharacters() -> Int
    func getCharacterDisplayModel(at index: Int) -> MarvelCharacterCellModel
    func shouldLoadMore(after index: Int) -> Bool
    func resetParams()
    func didSelectCharacter(at index: Int)
}

class CharacterListViewModel: CharacterListViewModelDelegate {
    private var disposeBag = DisposeBag()
    private var characters: [MarvelCharacter] = []
    private var offset = 0
    private let pageCount = 10
    private var currentKeyword: String?
    private weak var view: CharacterListViewControllerDelegate?
    
    // TODO: inject repo and router
    init(view: CharacterListViewControllerDelegate) {
        self.view = view
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
        let observable = CharacterRepository().getProductList(params: params)
        observable.subscribe(onNext: { [weak self] response in
            self?.checkNeedsReset(keyword: name)
            self?.getCharactersSucceeded(response: response)
        }, onError: { error in
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
        // TODO: router
//        let character = characters[index]
//        let detailsVC = storyboard?.instantiateViewController(
//            withIdentifier: String(describing: CharacterDetailsViewController.self))
//            as! CharacterDetailsViewController
//        detailsVC.character = character
//        detailsVC.modalPresentationStyle = .fullScreen
//        self.navigationController?.pushViewController(detailsVC, animated: true)
    }
    
    // MARK: Private
    
    private func showLoading() {
        if characters.isEmpty {
            view?.showLoadingIndicator()
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
    
    private func getCharactersSucceeded(response: GetCharactersResponse) {
        view?.hideLoading()
        if let newCharacters = response.data?.results, !newCharacters.isEmpty {
            characters.append(contentsOf: newCharacters)
            offset += newCharacters.count
            view?.reloadData()
        }
    }
}
