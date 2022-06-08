//
//  CharacterContentModel.swift
//  Marvelpedia
//
//  Created by Rana Moussa on 08/06/2022.
//

import Foundation

struct CharacterContentDetails: Codable {
    let title: String?
    let description: String?
    let thumbnail: CharacterThumbnail?
}
