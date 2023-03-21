//
//  ListScreenViewModel.swift
//  PresentationLayer
//
//  Created by user on 21.03.2023.
//

import Foundation
import DomainLayer

public final class ListScreenViewModel: ListScreenViewModelInterface {
    private var page = 1
    
    public var observeData: ((Result<[PresentationModel.ImageObject], Error>) -> ())?
    
    private var useCase: DownloadImageUseCaseInterface!
    
    public init(useCase: DownloadImageUseCaseInterface) {
        self.useCase = useCase
        
        self.useCase.observeData = { [weak self] result in
            switch result {
            case .success(let data):
                self?.observeData?(.success(data.map({ PresentationModel.ImageObject(data: $0) })))
            case .failure(let failure):
                self?.observeData?(.failure(failure))
                
                if (self?.page != 0) {
                    self?.page -= 1
                }
            }
        }
    }
    
    public func downloadImages() {
        useCase.downloadImages(page: page)
        page += 1
    }
}
