//
//  Configurator.swift
//  PicsumImageViewer
//
//  Created by user on 21.03.2023.
//

import Foundation
import PresentationLayer
import DomainLayer

final class Configurator {
    class func initializeListScreen(delegate: ListScreenDelegate) -> ListScreen {
        
        let useCase = DownloadImageUseCase()
        
        let viewModel = ListScreenViewModel(useCase: useCase)
        
        let viewController = ListScreen()
        viewController.coordinatorDelegate = delegate
        viewController.viewModel = viewModel
        
        return viewController
    }
    
    class func initializeImageScreen(delegate: ImageScreenDelegate) -> ImageScreen {
        let viewController = ImageScreen()
        viewController.coordinatorDelegate = delegate
        
        return viewController
    }
}
