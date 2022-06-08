//
//  CharactersRouterStub.swift
//  MarvelpediaTests
//
//  Created by Rana Moussa on 08/06/2022.
//

import Foundation
import UIKit
@testable import Marvelpedia

class CharactersRouterStub: CharactersRouterProtocol {
    var navigateToCharacterDetailsIsCalled = false
    var presentCharacterContentIsCalled = false
    var content: CharacterContent?
    
    var viewController: UIViewController?
    
    required init(viewController: UIViewController?) {
        
    }
    
    func navigateToCharacterDetailsPage(character: MarvelCharacter) {
        navigateToCharacterDetailsIsCalled = true
    }
    
    func presentCharacterContentSheet(_ content: CharacterContent) {
        presentCharacterContentIsCalled = true
        self.content = content
    }
}
