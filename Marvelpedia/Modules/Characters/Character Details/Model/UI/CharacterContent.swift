//
//  CharacterContentType.swift
//  Marvelpedia
//
//  Created by Rana Moussa on 07/06/2022.
//

import Foundation

enum CharacterContentType: String {
    case comics
    case series
    case stories
    case events
}

struct CharacterContent {
    typealias Content = (title: String, uri: String)
    let type: CharacterContentType
    let count: Int
    let content: [Content]
}
