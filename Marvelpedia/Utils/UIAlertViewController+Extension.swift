//
//  UIAlertViewController.swift
//  OcadoChallnge
//
//  Created by Rana Moussa on 28/04/2022.
//

import UIKit

extension UIAlertController {
    class func show(_ message: String, from controller: UIViewController) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        controller.present(alert, animated: true, completion: nil)
    }
}
