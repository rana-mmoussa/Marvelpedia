//
//  CharacterStoriesData.swift
//  Marvelpedia
//
//  Created by Rana Moussa on 03/06/2022.
//

import Foundation

struct CharacterStoriesData: Codable {
    let available: Int?
    let collectionURI: URL?
    let items: [StoryItem]?
    let returned: Int?
}

struct StoryItem: Codable {
    let resourceURI: URL?
    let name: String?
    
    var storyType: StoryType? {
        return StoryType(rawValue: name ?? "")
    }
}

enum StoryType: String, Codable {
    case cover = "cover"
    case interiorStory = "interiorStory"
}
