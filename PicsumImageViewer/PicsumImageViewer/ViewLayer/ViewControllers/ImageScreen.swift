//
//  ImageScreen.swift
//  PicsumImageViewer
//
//  Created by user on 21.03.2023.
//

import UIKit

protocol ImageScreenDelegate: AnyObject {
    func closeScreen()
}

class ImageScreen: UIViewController {
    /// Navigation
    weak var coordinatorDelegate: ImageScreenDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initUIComponents()
    }
    
    deinit {
        coordinatorDelegate?.closeScreen()
    }
    
    private func initUIComponents() {
        view.backgroundColor = .cyan
    }
}
