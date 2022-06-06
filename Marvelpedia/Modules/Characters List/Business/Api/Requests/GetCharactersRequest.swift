//
//  GetCharactersRequest.swift
//  Marvelpedia
//
//  Created by Rana Moussa on 24/04/2022.
//

import Foundation
import Alamofire

struct GetCharactersRequest: APIRequest {
    struct Params {
        let offset: Int
        let limit: Int
        let nameStartsWith: String?
    }
    
    var method = HTTPMethod.get
    var path: String {
        return CharacterEndpoint.list.getEndpoint()
    }
    var parameters = [String: Any]()
    
    init(params: Params) {
        parameters["offset"] = params.offset
        parameters["limit"] = params.limit
        if let startsWith = params.nameStartsWith, !startsWith.isEmpty {
            parameters["nameStartsWith"] = startsWith
        }
    }
}
