//
//  BaseViewController.swift
//  OcadoChallnge
//
//  Created by Rana Moussa on 25/04/2022.
//

import UIKit

typealias NavigationBarText = (title: String, isLarge: Bool)

class BaseViewController: UIViewController {
    private let activityIndicator = UIActivityIndicatorView(
        frame: CGRect(x: 0, y: 0, width: 50, height: 50))
    var navigationBarText: NavigationBarText = ("", false)

    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setTitleTextAttributes()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = navigationBarText.isLarge
        navigationItem.largeTitleDisplayMode = navigationBarText.isLarge ? .automatic : .never
        navigationItem.title = navigationBarText.title
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationItem.title = ""
    }
    
    func showActivityIndicator() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {
                return
            }
            self.activityIndicator.center = self.view.center
            self.activityIndicator.hidesWhenStopped = true
            self.activityIndicator.style = .medium
            self.activityIndicator.tintColor = .red
            self.view.window?.addSubview(self.activityIndicator)
            self.activityIndicator.startAnimating()
        }
    }

    func hideActivityIndicator() { 
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {
                return
            }
            self.activityIndicator.stopAnimating()
            self.activityIndicator.removeFromSuperview()
        }
    }
    
    // MARK: private
    private func setTitleTextAttributes() {
        navigationController?.navigationBar.titleTextAttributes = [
            .foregroundColor: UIColor.red
        ]
        navigationController?.navigationBar.largeTitleTextAttributes = [
            .foregroundColor: UIColor.red
        ]
        navigationController?.navigationBar.tintColor = .red
    }
}
