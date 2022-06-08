//
//  CharacterContentDetailsRequest.swift
//  Marvelpedia
//
//  Created by Rana Moussa on 08/06/2022.
//

import Foundation
import Alamofire

struct GetContentDetailsRequest: APIRequest {
    var method: HTTPMethod = .get
    var path: String
    var parameters: [String: Any] = [:]
    
    init(uri: String) {
        path = uri
    }
    
    func shouldOverrideBaseUrl() -> Bool {
        return true
    }
}
