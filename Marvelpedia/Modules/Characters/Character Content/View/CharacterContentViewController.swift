//
//  CharacterContentViewController.swift
//  Marvelpedia
//
//  Created by Rana Moussa on 07/06/2022.
//

import UIKit

class CharacterContentViewController: UIViewController {
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var contentCountView: UIView!
    @IBOutlet private weak var contentCountLabel: UILabel!
    @IBOutlet private weak var contentTypeLabel: UILabel!
    
    var characterContent: CharacterContent!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        setupTableView()
    }
    
    private func setupView() {
        contentCountView.layer.cornerRadius = contentCountView.frame.height / 2
        contentCountLabel.text = String(characterContent.count)
        contentTypeLabel.text = characterContent.type.rawValue.capitalized
    }
    
    private func setupTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "CharacterContentCell")
        if characterContent.count >= 20 {
            addTableviewFooterHint()
        }
    }
    
    private func addTableviewFooterHint() {
        let label = UILabel(frame: CGRect(x: CGFloat(0), y: CGFloat(0),
                                          width: tableView.bounds.width, height: CGFloat(44)))
        label.textAlignment = .center
        label.font = UIFont(name: Fonts.comicSans.rawValue, size: 10)
        label.text = "content_max".localized
        tableView.tableFooterView = label
        tableView.tableFooterView?.isHidden = false
    }
}

extension CharacterContentViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        characterContent.content.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CharacterContentCell", for: indexPath)
        let title = characterContent.content[indexPath.row].title
        cell.textLabel?.text = title
        cell.textLabel?.font = UIFont(name: Fonts.comicSans.rawValue, size: 16)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let uri = characterContent.content[indexPath.row].uri
        CharactersRouter(viewController: self).presentContentDetailsOf(uri: uri)
    }
}
