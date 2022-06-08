//
//  NetworkLayerProtocols.swift
//  Marvelpedia
//
//  Created by Rana Moussa on 24/04/2022.
//

import Foundation
import Alamofire

protocol NetworkEndpoint {
    func getEndpoint() -> String
}

protocol APIRequest {
    var method: HTTPMethod { get }
    var path: String { get }
    var parameters: [String: Any] { get }
    func shouldOverrideBaseUrl() -> Bool
}

extension APIRequest {
    func shouldOverrideBaseUrl() -> Bool {
        return false
    }
}
