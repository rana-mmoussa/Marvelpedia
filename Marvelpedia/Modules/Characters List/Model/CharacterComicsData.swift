//
//  CharacterComicsData.swift
//  Marvelpedia
//
//  Created by Rana Moussa on 03/06/2022.
//

import Foundation

struct CharacterComicsData: Codable {
    let available: Int?
    let collectionURI: URL?
    let items: [ComicsItem]?
    let returned: Int?
}

struct ComicsItem: Codable {
    let resourceURI: URL?
    let name: String?
}
