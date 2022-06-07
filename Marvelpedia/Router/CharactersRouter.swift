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
    init(viewController: UIViewController)
}

protocol CharactersRouterProtocol: BaseRouter  {
    func navigateToCharacterDetailsPage(character: MarvelCharacter)
    func presentCharacterContentSheet(_ content: CharacterContent)
}

class CharactersRouter: CharactersRouterProtocol {
    weak var viewController: UIViewController?
    private let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
    
    required init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    func navigateToCharacterDetailsPage(character: MarvelCharacter) {
        let detailsVC = mainStoryboard.instantiateViewController(
            withIdentifier: String(describing: CharacterDetailsViewController.self))
            as! CharacterDetailsViewController
        detailsVC.character = character
        detailsVC.modalPresentationStyle = .fullScreen
        viewController?.navigationController?.pushViewController(detailsVC, animated: true)
    }
    
    func presentCharacterContentSheet(_ content: CharacterContent) {
        let contentSheet = mainStoryboard.instantiateViewController(
            withIdentifier: String(describing: CharacterContentViewController.self))
        as! CharacterContentViewController
        contentSheet.characterContent = content
        let nav = UINavigationController(rootViewController: contentSheet)
        nav.modalPresentationStyle = .pageSheet
        nav.sheetPresentationController?.detents = [.medium(), .large()]
        nav.sheetPresentationController?.preferredCornerRadius = 16
        viewController?.present(nav, animated: true, completion: nil)
    }
}
