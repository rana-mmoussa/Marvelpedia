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

protocol CharacterListViewControllerDelegate: AnyObject {
    func showLoadingIndicator()
    func showBottomLoadingIndicator()
    func hideLoading()
    func reloadData()
}

class CharacterListViewController: BaseViewController {
    @IBOutlet private weak var tableView: UITableView!
    private var clearFiltersButton: UIBarButtonItem!
    private var searchController: UISearchController!
    
    private var viewModel: CharacterListViewModelDelegate!
    private var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationBarText = (title: "Marvelpedia", isLarge: true)
        viewModel = CharacterListViewModel(view: self)
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
                self.viewModel?.resetParams()
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
        viewModel?.resetParams()
        getCharacters()
    }
    
    @objc
    private func getCharacters(with name: String? = nil) {
        showActivityIndicator()
        reloadData()
        viewModel?.getCharacters(withName: name)
    }
}

extension CharacterListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.numberOfCharacters() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cellModel = viewModel?.getCharacterDisplayModel(at: indexPath.row) else {
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
        // TODO: better handling for cell animationn
//        cell.transform = CGAffineTransform(translationX: 0, y: cell.contentView.frame.height)
//        UIView.animate(withDuration: 0.3, delay: 0.05 * Double(indexPath.row), animations: {
//              cell.transform = CGAffineTransform(translationX: cell.contentView.frame.width, y: cell.contentView.frame.height)
//        })
        // TODO: show loading indicator in footer
        if viewModel?.shouldLoadMore(after: indexPath.row) ?? false {
            viewModel?.getCharacters(withName: searchController.searchBar.text)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel?.didSelectCharacter(at: indexPath.row)
    }
}

extension CharacterListViewController: CharacterListViewControllerDelegate {
    func showLoadingIndicator() {
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
        tableView.reloadData()
        let shouldShowClearButton = viewModel?.shouldShowClearButton ?? true
        navigationItem.rightBarButtonItem = shouldShowClearButton ? clearFiltersButton : nil
    }
}

