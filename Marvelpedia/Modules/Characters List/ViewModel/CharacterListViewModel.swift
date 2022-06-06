//
//  CharacterListViewModel.swift
//  Marvelpedia
//
//  Created by Rana Moussa on 06/06/2022.
//

import Foundation
import RxSwift

protocol CharacterListViewModelDelegate: AnyObject {
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
    private weak var view: CharacterListViewControllerDelegate?
    
    // TODO: inject repo and router
    init(view: CharacterListViewControllerDelegate) {
        self.view = view
    }
    
    func numberOfCharacters() -> Int {
        return characters.count
    }
    
    func getCharacters(withName name: String?) {
        let params = GetCharactersRequest.Params(offset: offset, limit: pageCount,
                                                 nameStartsWith: name)
        let observable = CharacterRepository().getProductList(params: params)
        observable.subscribe(onNext: { [weak self] response in
            if let newCharacters = response.data?.results, !newCharacters.isEmpty {
                self?.characters.append(contentsOf: newCharacters)
                self?.offset += newCharacters.count
                self?.view?.reloadData()
            }
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
    
}
