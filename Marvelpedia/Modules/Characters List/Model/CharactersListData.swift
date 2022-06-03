//
//  CharactersListData.swift
//  Marvelpedia
//
//  Created by Rana Moussa on 03/06/2022.
//

import Foundation

struct CharactersListData: Codable {
    let offset, limit, total, count: Int?
    let results: [MarvelCharacter]?
}
