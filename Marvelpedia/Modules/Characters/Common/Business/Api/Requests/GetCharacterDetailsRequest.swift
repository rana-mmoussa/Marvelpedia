//
//  GetCharacterDetailsRequest.swift
//  Marvelpedia
//
//  Created by Rana Moussa on 07/06/2022.
//

import Foundation
import Alamofire

struct GetCharacterDetailsRequest: APIRequest {
    var method = HTTPMethod.get
    var path: String {
        return CharacterEndpoint.details(characterId: characterId).getEndpoint()
    }
    var parameters = [String: Any]()
    var characterId: Double
    
    init(characterId: Double) {
        self.characterId = characterId
    }
}
