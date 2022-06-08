//
//  CharacterContentDetailsViewController.swift
//  Marvelpedia
//
//  Created by Rana Moussa on 08/06/2022.
//

import UIKit
import RxSwift

protocol CharacterContentDetailsViewControllerDelegate: AnyObject {
    func displayContentInfo(_ info: CharacterContentDetails)
}

class CharacterContentDetailsViewController: BaseViewController {
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    
    var uri: String!
    private var presenter: CharacterContentDetailsPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        presenter = CharacterContentDetailsPresenter(view: self,
                                                     router: CharactersRouter(viewController: self),
                                                     repo: CharacterRepository())
        showActivityIndicator()
        presenter?.getContentDetails(uri: uri)
    }
}

extension CharacterContentDetailsViewController: CharacterContentDetailsViewControllerDelegate {
    func displayContentInfo(_ info: CharacterContentDetails) {
        imageView.kf.setImage(with: info.thumbnail?.url)
        titleLabel.text = info.title
        descriptionLabel.text = info.description
        hideActivityIndicator()
    }
}
