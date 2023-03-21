//
//  ImageScreen.swift
//  PicsumImageViewer
//
//  Created by user on 21.03.2023.
//

import UIKit
import PresentationLayer

protocol ImageScreenDelegate: AnyObject {
    func closeScreen()
}

class ImageScreen: UIViewController {
    /// Navigation
    weak var coordinatorDelegate: ImageScreenDelegate?
    
    /// Data Properties
    let image: PresentationModel.Image
    
    init(image: PresentationModel.Image) {
        self.image = image
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
