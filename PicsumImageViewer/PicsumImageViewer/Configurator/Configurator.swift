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
        
        let useCase = DownloadImagesUseCase()
        
        let viewModel = ListScreenViewModel(useCase: useCase)
        
        let viewController = ListScreen()
        viewController.coordinatorDelegate = delegate
        viewController.viewModel = viewModel
        
        return viewController
    }
    
    class func initializeImageScreen(delegate: ImageScreenDelegate, image: PresentationModel.Image) -> ImageScreen {
        let viewController = ImageScreen(image: image)
        viewController.coordinatorDelegate = delegate
        
        return viewController
    }
}
