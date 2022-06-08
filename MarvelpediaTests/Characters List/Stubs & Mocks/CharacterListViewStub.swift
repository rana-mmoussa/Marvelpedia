//
//  CharacterListViewStub.swift
//  MarvelpediaTests
//
//  Created by Rana Moussa on 08/06/2022.
//

import Foundation
@testable import Marvelpedia

class CharacterListViewStub: CharacterListViewControllerDelegate {
    var bottomLoadingIsShown = false
    var dataIsReloaded = false
    var loadingIsShown = false
    var loadingIsHidden = false
    
    func showBottomLoadingIndicator() {
        bottomLoadingIsShown = true
    }
    
    func reloadData() {
        dataIsReloaded = true
    }
    
    func showLoading() {
        loadingIsShown = true
    }
    
    func hideLoading() {
        loadingIsHidden = true
    }
}
