//
//  CharacterListViewController.swift
//  Marvelpedia
//
//  Created by Rana Moussa on 03/06/2022.
//

import UIKit
import RxSwift
import RxCocoa
import Hero

protocol BaseViewProtocol: AnyObject {
    func showLoading()
    func hideLoading()
}

protocol CharacterListViewControllerDelegate: BaseViewProtocol {
    func showBottomLoadingIndicator()
    func reloadData()
}

class CharacterListViewController: BaseViewController {
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var scrollUpButton: UIButton!
    
    @IBAction private func scrollUpButtonClicked() {
        scrollUp()
    }
    
    private var clearFiltersButton: UIBarButtonItem!
    private var searchController: UISearchController!
    
    private var presenter: CharacterListPresenterDelegate!
    private var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationBarText = (title: "Marvelpedia", isLarge: true)
        presenter = CharacterListPresenter(view: self,
                                           router: CharactersRouter(viewController: self),
                                           repo: CharacterRepository())
        setupTableView()
        setupSearchBar()
        setupClearFiltersButton()
    }
    
    private func setupTableView() {
        tableView.register(UINib(nibName: MarvelCharacterTableViewCell.identifier,
                                 bundle: nil),
                           forCellReuseIdentifier: MarvelCharacterTableViewCell.identifier)
        tableView.separatorStyle = .none
    }
    
    private func setupSearchBar() {
        searchController = {
            let controller = UISearchController(searchResultsController: nil)
            controller.obscuresBackgroundDuringPresentation = false
            controller.searchBar.placeholder = "Character Name.."
            return controller
        }()
        navigationItem.searchController = searchController
        bindSearchbarToSearch()
    }
    
    private func bindSearchbarToSearch() {
        searchController.searchBar
            .rx.text
            .debounce(DispatchTimeInterval.milliseconds(300), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .subscribe(onNext: { [unowned self] text in
                self.presenter?.resetParams()
                self.getCharacters(with: text)
            }).disposed(by: disposeBag)
    }
    
    private func setupClearFiltersButton() {
        clearFiltersButton = UIBarButtonItem(title: "Clear Filters", style: .plain,
                                             target: self, action: #selector(clearFilters))
        clearFiltersButton.tintColor = .red
    }
    
    @objc
    private func clearFilters() {
        searchController.searchBar.text = nil
        presenter?.resetParams()
        getCharacters()
    }
    
    @objc
    private func getCharacters(with name: String? = nil) {
        showActivityIndicator()
        reloadData()
        presenter?.getCharacters(withName: name)
    }
    
    private func scrollUp() {
        tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
    }
}

extension CharacterListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.numberOfCharacters() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cellModel = presenter?.getCharacterDisplayModel(at: indexPath.row) else {
            return UITableViewCell()
        }
        let cell = tableView.dequeueReusableCell(
            withIdentifier: MarvelCharacterTableViewCell.identifier,
            for: indexPath) as! MarvelCharacterTableViewCell
        cell.setup(with: cellModel)
        cell.hero.id = "skyWalker"
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell,
                   forRowAt indexPath: IndexPath) {
        if presenter?.shouldLoadMore(after: indexPath.row) ?? false {
            presenter?.getCharacters(withName: searchController.searchBar.text)
        }
        if tableView.scrollingDirection() == .down {
            showCellAnimation(for: cell, at: indexPath)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.didSelectCharacter(at: indexPath.row)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollUpButton.isHidden = scrollView.contentOffset.y <= 0
    }
    
    // helper methods
    private func showCellAnimation(for cell: UITableViewCell, at indexPath: IndexPath) {
        cell.transform = CGAffineTransform(translationX: 0, y: cell.contentView.frame.height)
        UIView.animate(withDuration: 0.3, animations: {
              cell.transform = CGAffineTransform(translationX: cell.contentView.frame.width, y: cell.contentView.frame.height)
        })
    }
}

extension CharacterListViewController: CharacterListViewControllerDelegate {
    func showLoading() {
        showActivityIndicator()
    }
    
    func showBottomLoadingIndicator() {
        let spinner = UIActivityIndicatorView(style: .medium)
        spinner.startAnimating()
        spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0),
                               width: tableView.bounds.width, height: CGFloat(44))
        tableView.tableFooterView = spinner
        tableView.tableFooterView?.isHidden = false
    }
    
    func hideLoading() {
        hideActivityIndicator()
        tableView.tableFooterView = nil
    }
    
    func reloadData() {
        UIView.performWithoutAnimation {
            tableView.reloadSections([0], with: .none)
        }
        let shouldShowClearButton = presenter?.shouldShowClearButton ?? true
        navigationItem.rightBarButtonItem = shouldShowClearButton ? clearFiltersButton : nil
    }
}

