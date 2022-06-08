//
//  CharactersRepoMock.swift
//  MarvelpediaTests
//
//  Created by Rana Moussa on 08/06/2022.
//

import Foundation
import RxSwift
@testable import Marvelpedia

class CharactersRepoMock: CharacterRepositoryProtocol {
    func getCharactersList(params: GetCharactersRequest.Params) -> Observable<GetCharactersListResponse> {
        let response: GetCharactersListResponse = getResponseFrom(jsonFile: "ListCharactersResponse")!
        return PublishSubject.just(response)
    }
    
    func getCharacterDetails(withId id: Double) -> Observable<GetCharacterResponse> {
        let response: GetCharacterResponse = getResponseFrom(jsonFile: "ListCharactersResponse")!
        return PublishSubject.just(response)
    }
}
