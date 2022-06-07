//
//  BaseMarvelResponse.swift
//  Marvelpedia
//
//  Created by Rana Moussa on 07/06/2022.
//

import Foundation

struct BaseMarvelResponse<T: Codable>: Codable {
    let code: Int?
    let status, copyright, attributionText, attributionHTML, message: String?
    let etag: String?
    let data: BaseMarvelResponseData<T>?
}
