//
//  GetCharactersResponse.swift
//  Marvelpedia
//
//  Created by Rana Moussa on 03/06/2022.
//

import Foundation

// MARK: - GetCharactersResponse
struct GetCharactersResponse: Codable {
    let code: Int?
    let status, copyright, attributionText, attributionHTML, message: String?
    let etag: String?
    let data: CharactersListData?
}
