//
//  CharacterThumbnail.swift
//  Marvelpedia
//
//  Created by Rana Moussa on 03/06/2022.
//

import Foundation

struct CharacterThumbnail: Codable {
    let path: URL?
    let thumbnailExtension: String?
    var url: URL? {
        path?.appendingPathExtension(thumbnailExtension ?? "")
    }

    enum CodingKeys: String, CodingKey {
        case path
        case thumbnailExtension = "extension"
    }
}
