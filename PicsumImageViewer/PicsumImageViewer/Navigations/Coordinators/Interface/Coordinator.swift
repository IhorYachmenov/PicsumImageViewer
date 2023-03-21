//
//  Coordinator.swift
//  PicsumImageViewer
//
//  Created by user on 21.03.2023.
//

import Foundation

protocol Coordinator: AnyObject {
    var children: [Coordinator] { get set }
    var router: Router { get }
    
    func start()
    func stop()
    func coordinate(to coordinator: Coordinator)
}

extension Coordinator {
    func coordinate(to coordinator: Coordinator) {
        children.append(coordinator)
        coordinator.start()
    }
    
    func removeChild(_ coordinator: Coordinator) {
        children.removeAll { $0 === coordinator }
    }
}
