//
//  CharacterSeriesData.swift
//  Marvelpedia
//
//  Created by Rana Moussa on 03/06/2022.
//

import Foundation

struct CharacterSeriesData: Codable {
    let available: Int?
    let collectionURI: URL?
    let items: [SeriesItem]?
    let returned: Int?
}

struct SeriesItem: Codable {
    let resourceURI: URL?
    let name: String?
}
