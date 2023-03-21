//
//  Configurator.swift
//  PicsumImageViewer
//
//  Created by user on 21.03.2023.
//

import Foundation

final class Configurator {
    class func initializeListScreen(delegate: ListScreenDelegate) -> ListScreen {
        let viewController = ListScreen()
        viewController.coordinatorDelegate = delegate
        print("initializeListScreen")
        return viewController
    }
    
    class func initializeImageScreen(delegate: ImageScreenDelegate) -> ImageScreen {
        let viewController = ImageScreen()
        viewController.coordinatorDelegate = delegate
        
        return viewController
    }
}
