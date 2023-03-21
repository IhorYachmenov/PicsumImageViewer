//
//  ListScreenCoordinator.swift
//  PicsumImageViewer
//
//  Created by user on 21.03.2023.
//

import Foundation

final class ListScreenCoordinator: Coordinator {
    var children: [Coordinator] = []
    let router: Router
    
    init(router: Router) {
        self.router = router
    }
    
    func start() {
        let listScreen = Configurator.initializeListScreen(delegate: self)
        router.push(listScreen, animated: true)
    }
    
    func stop() {
        router.dismiss(animated: true) { [weak self] in
            guard let self = self else { return }
            self.removeChild(self)
        }
    }
    
    private func openImageCoordinator() {
        let imageCoordinator = ImageScreenCoordinator(router: router)
        coordinate(to: imageCoordinator)
        
        imageCoordinator.didFinished = { [weak self, weak imageCoordinator] in
            guard let self = self else { return }
            self.children.removeAll(where: { $0 === imageCoordinator})
        }
    }
}

// MARK: - Delegate
extension ListScreenCoordinator: ListScreenDelegate {
    func openImageScreen() {
        openImageCoordinator()
    }
}
