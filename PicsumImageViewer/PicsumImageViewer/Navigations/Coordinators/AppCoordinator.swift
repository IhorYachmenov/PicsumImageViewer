//
//  AppCoordinator.swift
//  PicsumImageViewer
//
//  Created by user on 21.03.2023.
//

import Foundation
import UIKit

// MARK: - App Coordinator
final class AppCoordinator: Coordinator {
    var children: [Coordinator] = []
    let router: Router
    let window: UIWindow
    
    init(window: UIWindow, router: Router) {
        self.window = window
        self.router = router
        
        setupWindow()
    }
    
    func start() {
        let listScreenCoordinator = ListScreenCoordinator(router: router)
        coordinate(to: listScreenCoordinator)
    }
    
    func stop() {
        // -
    }
}
