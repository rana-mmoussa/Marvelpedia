//
//  TestHelpers.swift
//  MarvelpediaTests
//
//  Created by Rana Moussa on 08/06/2022.
//

import Foundation

extension Bundle {
    public class var testBundle: Bundle {
        return Bundle(for: CharactersListPresenterTests.self)
    }
}

// MARK: helpers
func getResponseFrom<T: Decodable>(jsonFile: String) -> T? {
    guard let filePath = Bundle.testBundle.path(forResource: jsonFile, ofType: "json") else {
        print("Error: content not found")
        return nil
    }
    
    do {
        let data = try Data(contentsOf: URL(fileURLWithPath: filePath), options: .mappedIfSafe)
        return try JSONDecoder().decode(T.self, from: data)
    } catch(let error) {
        print("Error: couldn't parse json file content, \(error.localizedDescription)")
        return nil
    }
}
