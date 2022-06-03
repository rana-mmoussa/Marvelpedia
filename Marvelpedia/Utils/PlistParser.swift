//
//  PlistParser.swift
//  Marvelpedia
//
//  Created by Rana Moussa on 03/06/2022.
//

import Foundation

enum PlistFile: String {
    case marvelApi = "MarvelAPI"
}

enum PlistKey: String {
    case marvelPublicKey = "PublicKey"
    case marvelPrivateKey = "PrivateKey"
}

class PlistParser {
    var file: PlistFile
    private var plistData = [String: Any]()
    
    // implemented using a failable init in cas file doesn't exist
    init?(file: PlistFile) {
        self.file = file
        if let plistData = readFromFile() {
            self.plistData = plistData
        } else {
            return nil
        }
    }
    
    func getValue<ValueType>(for key: String) -> ValueType? {
        return plistData[key] as? ValueType
    }
    
    private func readFromFile() -> [String: Any]? {
        guard let path = Bundle.main.path(forResource: file.rawValue, ofType: "plist") else {
            debugPrint("Path not found")
            return nil
        }

        guard let dictionary = NSDictionary(contentsOfFile: path) else {
            debugPrint("Unable to get dictionary from path")
            return nil
        }
        
        return dictionary as? [String : Any]
    }
}
