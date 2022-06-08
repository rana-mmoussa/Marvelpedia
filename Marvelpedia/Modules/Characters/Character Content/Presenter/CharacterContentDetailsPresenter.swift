//
//  CharacterContentDetailsPresenter.swift
//  Marvelpedia
//
//  Created by Rana Moussa on 08/06/2022.
//

import Foundation
import RxSwift

protocol CharacterContentDetailsPresenterDelegate {
    func getContentDetails(uri: String)
}

class CharacterContentDetailsPresenter: CharacterContentDetailsPresenterDelegate {
    private weak var view: CharacterContentDetailsViewControllerDelegate?
    private var repo: CharacterRepositoryProtocol
        
    private var disposeBag = DisposeBag()
    
    init(view: CharacterContentDetailsViewControllerDelegate,
         repo: CharacterRepositoryProtocol) {
        self.view = view
        self.repo = repo
    }
    
    func getContentDetails(uri: String) {
        let observable = repo.getCharacterContent(uri: uri)
        observable.subscribe(onNext: { [weak self] response in
            if let info = response.data?.results?.first {
                self?.view?.displayContentInfo(info)
            }
            
        }, onError: { error in
            // TODO: error handling
            print(error.localizedDescription)
        }).disposed(by: disposeBag)
    }
}
