//
//  ListScreenViewModel.swift
//  PresentationLayer
//
//  Created by user on 21.03.2023.
//

import Foundation
import DomainLayer

public final class ListScreenViewModel: ListScreenViewModelInterface {
    private var page = 2
    
    public var observeData: ((Result<[PresentationModel.Image], Error>) -> ())?
    
    private var useCase: DownloadImagesUseCaseInterface!
    
    public init(useCase: DownloadImagesUseCaseInterface) {
        self.useCase = useCase
        
        self.useCase.observeData = { [weak self] result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    self?.observeData?(.success(data.map({ PresentationModel.Image(data: $0) })))
                }
                
            case .failure(let failure):
                DispatchQueue.main.async {
                    self?.observeData?(.failure(failure))
                }
                
                self?.repeatLoadingIfFailure()
                
                if (self?.page != 1) {
                    self?.page -= 1
                }
            }
        }
    }
    
    public func downloadImages() {
        useCase.downloadImages(page: page)
        page += 1
    }
    
    private func repeatLoadingIfFailure() {
        DispatchQueue.global().asyncAfter(deadline: .now() + 5.0, execute: { [weak self] in
            self?.downloadImages()
        })
    }
}
