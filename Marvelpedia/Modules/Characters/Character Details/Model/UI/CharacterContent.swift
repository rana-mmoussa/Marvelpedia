//
//  CharacterContentType.swift
//  Marvelpedia
//
//  Created by Rana Moussa on 07/06/2022.
//

import Foundation

enum CharacterCotnentType: String {
    case comics
    case series
    case stories
    case events
}

struct CharacterContent {
    let type: CharacterCotnentType
    let count: Int
    let titles: [String]
}
