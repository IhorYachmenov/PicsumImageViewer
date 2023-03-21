//
//  ViewController.swift
//  PicsumImageViewer
//
//  Created by user on 21.03.2023.
//

import UIKit

extension UIViewController {
    func presentAlertController(msg: String) {
        let alert = UIAlertController(title: Constants.Alert.Confirm, message: msg, preferredStyle: .alert)
        
        let action = UIAlertAction(title: Constants.Alert.Confirm, style: .destructive)
        alert.addAction(action)
        present(alert, animated: true)
    }
}
