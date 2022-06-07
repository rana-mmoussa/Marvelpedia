//
//  CharacterRepository.swift
//  Marvelpedia
//
//  Created by Rana Moussa on 03/06/2022.
//

import Foundation
import RxSwift

protocol CharacterRepositoryProtocol {
    func getCharactersList(params: GetCharactersRequest.Params) -> Observable<GetCharactersListResponse>
    func getCharacterDetails(withId id: Double) -> Observable<GetCharacterResponse>
}

struct CharacterRepository: CharacterRepositoryProtocol {
    private let networkManager = BaseNetworkLayer.shared
    
    func getCharactersList(params: GetCharactersRequest.Params) -> Observable<GetCharactersListResponse> {
        let request = GetCharactersRequest(params: params)
        return networkManager.makeRequest(request: request)
    }
    
    func getCharacterDetails(withId id: Double) -> Observable<GetCharacterResponse> {
        let request = GetCharacterDetailsRequest(characterId: id)
        return networkManager.makeRequest(request: request)
    }
}
