//
//  CharacterDetailsViewController.swift
//  Marvelpedia
//
//  Created by Rana Moussa on 04/06/2022.
//

import UIKit

protocol CharacterDetailsViewControllerDelegate: BaseViewProtocol {
    func displayCharacter(_ character: MarvelCharacter)
}

class CharacterDetailsViewController: BaseViewController {
    @IBOutlet private weak var characterImageView: UIImageView!
    @IBOutlet private weak var characterInfoView: UIView!
    @IBOutlet private weak var characterNameLabel: UILabel!
    @IBOutlet private weak var characterDescriptionLabel: UILabel!
    @IBOutlet private weak var numberOfComicsLabel: UILabel!
    @IBOutlet private weak var numberOfSeriesLabel: UILabel!
    @IBOutlet private weak var numberOfStoriesLabel: UILabel!
    @IBOutlet private weak var comicsView: UIView!
    @IBOutlet private weak var seriesView: UIView!
    @IBOutlet private weak var storiesView: UIView!
    
    @IBAction private func comicsButtonClicked() {
        presenter?.comicsButtonClicked()
    }
    
    @IBAction private func seriesButtonClicked() {
        presenter?.seriesButtonClicked()
    }
    
    @IBAction private func storiesButtonClicked() {
        presenter?.storiesButtonClicked()
    }
    
    private var presenter: CharacterDetailsPresenter?
    // TODO: encapsulate this
    var character: MarvelCharacter?

    override func viewDidLoad() {
        super.viewDidLoad()

        presenter = CharacterDetailsPresenter(view: self,
                                              router: CharactersRouter(viewController: self),
                                              repo: CharacterRepository())
        navigationBarText = (title: "", isLarge: false)
        setupViews()
        displayCharacterInfo()
        presenter?.getCharacter(with: character?.id ?? 0)
    }
    
    private func setupViews() {
        characterInfoView.layer.cornerRadius = 16
        characterInfoView.layer.shadowOpacity = 0.3
        characterInfoView.layer.shadowColor = UIColor.gray.cgColor
        comicsView.layer.cornerRadius = 8
        seriesView.layer.cornerRadius = 8
        storiesView.layer.cornerRadius = 8
    }
    
    private func displayCharacterInfo() {
        guard let character = character else {
            return
        }
        let url = character.thumbnail?.url
        characterImageView.kf.setImage(with: url)
        characterNameLabel.text = character.name
        characterDescriptionLabel.text = character.resultDescription
        numberOfComicsLabel.text = "\(character.comics?.available ?? 0) Comics"
        numberOfSeriesLabel.text = "\(character.series?.available ?? 0) Series"
        numberOfStoriesLabel.text = "\(character.stories?.available ?? 0) Stories"
    }
}

extension CharacterDetailsViewController: CharacterDetailsViewControllerDelegate {
    func showLoading() {
        showActivityIndicator()
    }
    
    func hideLoading() {
        hideActivityIndicator()
    }
    
    func displayCharacter(_ character: MarvelCharacter) {
        self.character = character
        displayCharacterInfo()
    }
}
