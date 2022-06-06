//
//  MarvelCharacterTableViewCell.swift
//  Marvelpedia
//
//  Created by Rana Moussa on 04/06/2022.
//

import UIKit
import Kingfisher

struct MarvelCharacterCellModel {
    let character: CharacterUIModel
    let isMirrored: Bool
}

class MarvelCharacterTableViewCell: UITableViewCell {
    static let identifier = String(describing: MarvelCharacterTableViewCell.self)
    @IBOutlet private weak var backgroundColorView: UIView!
    @IBOutlet private weak var stackView: UIStackView!
    @IBOutlet private weak var characterImageContainerView: UIView!
    @IBOutlet private weak var characterImageView: UIImageView!
    @IBOutlet private weak var characterNameLabel: UILabel!
    @IBOutlet private weak var characterDescriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        backgroundColorView.layer.cornerRadius = 8
        backgroundColorView.layer.shadowOpacity = 0.2
        backgroundColorView.layer.shadowColor = UIColor.gray.cgColor
        selectionStyle =  .none
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        stackView.removeArrangedSubview(characterImageContainerView)
        stackView.insertArrangedSubview(characterImageContainerView, at: 0)
    }
    
    func setup(with model: MarvelCharacterCellModel) {
        characterImageView.kf.setImage(with: model.character.imageUrl,
                                       completionHandler: { [weak self] result in
            switch result {
            case .success(let retrievedImage):
                self?.backgroundColorView.backgroundColor = retrievedImage.image.averageColor?.withAlphaComponent(0.75)
            case .failure(_):
                // TODO: placeholder image
                break
            }
        })
        characterNameLabel.text = model.character.name
        characterDescriptionLabel.text = model.character.description
        if model.isMirrored {
            stackView.removeArrangedSubview(characterImageContainerView)
            stackView.addArrangedSubview(characterImageContainerView)
        }
    }
    
}
