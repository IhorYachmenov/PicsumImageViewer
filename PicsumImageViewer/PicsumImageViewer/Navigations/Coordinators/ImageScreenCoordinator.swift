//
//  ImageScreenCoordinator.swift
//  PicsumImageViewer
//
//  Created by user on 21.03.2023.
//

import Foundation

final class ImageScreenCoordinator: Coordinator {
    var children: [Coordinator] = []
    let router: Router
    var didFinished: (() -> Void)?
    
    init(router: Router) {
        self.router = router
    }
    
    func start() {
        let imageScreen = Configurator.initializeImageScreen(delegate: self)
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
