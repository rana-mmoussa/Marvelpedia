//
//  ProductsEndpoints.swift
//  Marvelpedia
//
//  Created by Rana Moussa on 03/06/2022.
//

import Foundation

enum CharacterEndpoint: NetworkEndpoint {
    case list
    case details(characterId: Double)
    
    func getEndpoint() -> String {
        switch self {
        case .list:
            return "/v1/public/characters"
            
        case .details(let characterId):
            return "/v1/public/characters/\(characterId)"
        }
    }
}


