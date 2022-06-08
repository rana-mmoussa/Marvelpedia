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
    private var router: CharactersRouterProtocol
    private var repo: CharacterRepositoryProtocol
        
    private var disposeBag = DisposeBag()
    
    init(view: CharacterContentDetailsViewControllerDelegate,
         router: CharactersRouterProtocol,
         repo: CharacterRepositoryProtocol) {
        self.view = view
        self.router = router
        self.repo = repo
    }
    
    func getContentDetails(uri: String) {
        let observable = repo.getCharacterContent(uri: uri)
        observable.subscribe(onNext: { [weak self] response in
            if let info = response.data?.results?.first {
                self?.view?.displayContentInfo(info)
            }
            
        }, onError: {  [weak self] error in
            self?.router.showAlert("content_error_message".localized)
            
        }).disposed(by: disposeBag)
    }
}
