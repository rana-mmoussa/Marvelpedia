//
//  CharacterEventsData.swift
//  Marvelpedia
//
//  Created by Rana Moussa on 03/06/2022.
//

import Foundation

struct CharacterEventsData: Codable {
    let available: Int?
    let collectionURI: URL?
    let items: [EventItem]?
    let returned: Int?
}

struct EventItem: Codable {
    let resourceURI: URL?
    let name: String?
}
