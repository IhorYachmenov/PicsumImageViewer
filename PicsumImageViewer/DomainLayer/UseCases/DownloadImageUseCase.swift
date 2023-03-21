//
//  DownloadImageUseCase.swift
//  DomainLayer
//
//  Created by user on 21.03.2023.
//

import Foundation

public final class DownloadImageUseCase: DownloadImageUseCaseInterface {
    public var observeData: ((Result<[DomainModel.ImageObject], Error>) -> ())?
    
    public init() {
        
    }
    
    public func downloadImages(page: Int) {
        print("Domain download")
    }
}
