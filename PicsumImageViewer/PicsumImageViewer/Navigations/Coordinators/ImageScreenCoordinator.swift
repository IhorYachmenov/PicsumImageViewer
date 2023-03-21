//
//  ImageScreenCoordinator.swift
//  PicsumImageViewer
//
//  Created by user on 21.03.2023.
//

import Foundation
import PresentationLayer

final class ImageScreenCoordinator: Coordinator {
    var children: [Coordinator] = []
    let router: Router
    var didFinished: (() -> Void)?
    
    private let image: PresentationModel.Image
    
    init(router: Router, image: PresentationModel.Image) {
        self.router = router
        self.image = image
    }
    
    func start() {
        let imageScreen = Configurator.initializeImageScreen(delegate: self, image: image)
        router.push(imageScreen, animated: true)
    }
    
    func stop() {
        router.dismiss(animated: true) { [weak self] in
            guard let self = self else { return }
            self.removeChild(self)
            self.didFinished?()
        }
    }
}

// MARK: - Delegate
extension ImageScreenCoordinator: ImageScreenDelegate {
    func closeScreen() {
        stop()
    }
}
