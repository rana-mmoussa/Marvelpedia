//
//  CharacterDetailsViewController.swift
//  Marvelpedia
//
//  Created by Rana Moussa on 04/06/2022.
//

import UIKit

class CharacterDetailsViewController: UIViewController {
    
    @IBOutlet weak var characterImageView: UIImageView!
    @IBOutlet weak var characterInfoView: UIView!
    @IBOutlet weak var characterNameLabel: UILabel!
    @IBOutlet weak var characterDescriptionLabel: UILabel!
    @IBOutlet weak var numberOfComicsLabel: UILabel!
    @IBOutlet weak var numberOfSeriesLabel: UILabel!
    @IBOutlet weak var numberOfStoriesLabel: UILabel!
    @IBOutlet weak var comicsView: UIView!
    @IBOutlet weak var seriesView: UIView!
    @IBOutlet weak var storiesView: UIView!
    
    var characterId: Double!
    var character: MarvelCharacter!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationController?.navigationBar.prefersLargeTitles = false
        let url = character.thumbnail!.path!.appendingPathExtension(character.thumbnail!.thumbnailExtension!)
        characterImageView.kf.setImage(with: url)
        characterInfoView.layer.cornerRadius = 16
        characterInfoView.layer.shadowOpacity = 0.3
        characterInfoView.layer.shadowColor = UIColor.gray.cgColor
        comicsView.layer.cornerRadius = 8
        seriesView.layer.cornerRadius = 8
        storiesView.layer.cornerRadius = 8
        
        characterNameLabel.text = character.name
        characterDescriptionLabel.text = character.resultDescription
        numberOfComicsLabel.text = "\(character.comics?.items?.count ?? 0) Comics"
        numberOfSeriesLabel.text = "\(character.series?.items?.count ?? 0) Series"
        numberOfStoriesLabel.text = "\(character.stories?.items?.count ?? 0) Stories"
    }

}
