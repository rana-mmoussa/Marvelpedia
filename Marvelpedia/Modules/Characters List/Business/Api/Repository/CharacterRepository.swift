//
//  CharacterRepository.swift
//  Marvelpedia
//
//  Created by Rana Moussa on 03/06/2022.
//

import Foundation
import RxSwift

protocol CharacterRepositoryProtocol {
    func getProductList() -> Observable<GetCharactersResponse>
//    func getProductDetails(withId id: Int) -> Observable<MarvelCharacter>
}

struct CharacterRepository: CharacterRepositoryProtocol {
    private let networkManager = BaseNetworkLayer.shared
    
    func getProductList() -> Observable<GetCharactersResponse> {
        let request = GetCharactersRequest()
        return networkManager.makeRequest(request: request)
    }
    
//    func getProductDetails(withId id: Int) -> Observable<MarvelCharacter> {
//        let request = GetProductDetailsRequest(productId: id)
//        return networkManager.makeRequest(request: request)
//    }
}
