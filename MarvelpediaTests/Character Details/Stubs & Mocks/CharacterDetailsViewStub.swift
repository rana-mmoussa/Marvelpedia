//
//  CharacterDetailsViewStub.swift
//  MarvelpediaTests
//
//  Created by Rana Moussa on 08/06/2022.
//

import Foundation
@testable import Marvelpedia

class CharacterDetailsViewStub: CharacterDetailsViewControllerDelegate {
    var didDisplayCharacter = false
    var character: MarvelCharacter?
    var loadingIsShown = false
    var loadingIsHidden = false
    
    func displayCharacter(_ character: MarvelCharacter) {
        didDisplayCharacter = true
        self.character = character
    }
    
    func showLoading() {
        loadingIsShown = true
    }
    
    func hideLoading() {
        loadingIsHidden = true
    }
    
}
