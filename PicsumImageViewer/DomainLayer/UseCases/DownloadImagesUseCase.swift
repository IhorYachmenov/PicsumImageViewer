//
//  DownloadImageUseCase.swift
//  DomainLayer
//
//  Created by user on 21.03.2023.
//

import Foundation
import NetworkLayer

// MARK: - In this example I use simple Network Layer, because URL will hardcoded directly, if needed we can discuss some moments
public final class DownloadImagesUseCase: DownloadImagesUseCaseInterface {
    public var observeData: ((Result<[DomainModel.Image], Error>) -> ())?
    
    let networkClient = NetworkClient()
    
    public init() {
        downloadImages(page: 1)
    }
    
    public func downloadImages(page: Int) {
        networkClient.downloadImages(url: "https://picsum.photos/v2/list?page=\(page)&limit=20") { [weak self] result in
            switch result {
            case .success(let success):
                self?.observeData?(.success(success.map({ DomainModel.Image(data: $0)} )))
            case .failure(let failure):
                self?.observeData?(.failure(failure))
            }
        }
    }
}
