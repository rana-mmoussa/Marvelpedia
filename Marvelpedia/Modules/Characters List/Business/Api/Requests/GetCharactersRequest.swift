//
//  GetCharactersRequest.swift
//  Marvelpedia
//
//  Created by Rana Moussa on 24/04/2022.
//

import Foundation
import Alamofire

struct GetCharactersRequest: APIRequest {
    var method = HTTPMethod.get
    var path: String {
        return CharacterEndpoint.list.getEndpoint()
    }
    var parameters = [String: String]()
}
