//
//  MarvelCharacter.swift
//  Marvelpedia
//
//  Created by Rana Moussa on 03/06/2022.
//

import Foundation

struct MarvelCharacter: Codable {
    let id: Double
    let name, resultDescription: String?
    let modified: String?
    let thumbnail: CharacterThumbnail?
    let resourceURI: URL?
    let comics: CharacterComicsData?
    let series: CharacterSeriesData?
    let stories: CharacterStoriesData?
    let events: CharacterEventsData?
    let urls: [CharacterURLElement]?

    enum CodingKeys: String, CodingKey {
        case id, name
        case resultDescription = "description"
        case modified, thumbnail, resourceURI, comics, series, stories, events, urls
    }
}
