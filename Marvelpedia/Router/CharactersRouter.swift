//
//  CharactersRouter.swift
//  Marvelpedia
//
//  Created by Rana Moussa on 07/06/2022.
//

import Foundation
import UIKit

protocol BaseRouter {
    var viewController: UIViewController? { get }
    init(viewController: UIViewController?)
}

protocol CharactersRouterProtocol: BaseRouter  {
    func navigateToCharacterDetailsPage(character: MarvelCharacter)
    func presentCharacterContent(_ content: CharacterContent)
    func presentContentDetailsOf(uri: String)
}

class CharactersRouter: CharactersRouterProtocol {
    weak var viewController: UIViewController?
    private let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
    
    required init(viewController: UIViewController?) {
        self.viewController = viewController
    }
    
    func navigateToCharacterDetailsPage(character: MarvelCharacter) {
        let detailsVC = mainStoryboard.instantiateViewController(
            withIdentifier: String(describing: CharacterDetailsViewController.self))
            as! CharacterDetailsViewController
        detailsVC.character = character
        viewController?.navigationController?.pushViewController(detailsVC, animated: true)
    }
    
    func presentCharacterContent(_ content: CharacterContent) {
        let contentSheet = mainStoryboard.instantiateViewController(
            withIdentifier: String(describing: CharacterContentViewController.self))
        as! CharacterContentViewController
        contentSheet.characterContent = content
        viewController?.present(contentSheet, animated: true, completion: nil)
    }
    
    func presentContentDetailsOf(uri: String) {
        let contentSheet = mainStoryboard.instantiateViewController(
            withIdentifier: String(describing: CharacterContentDetailsViewController.self))
        as! CharacterContentDetailsViewController
        contentSheet.uri = uri
        contentSheet.modalPresentationStyle = .pageSheet
        contentSheet.sheetPresentationController?.detents = [.medium(), .large()]
        contentSheet.sheetPresentationController?.preferredCornerRadius = 16
        viewController?.present(contentSheet, animated: true, completion: nil)
    }
    
}
