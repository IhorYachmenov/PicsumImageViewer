//
//  ListScreenViewModel.swift
//  PresentationLayer
//
//  Created by user on 21.03.2023.
//

import Foundation

public final class ListScreenViewModel: ListScreenViewModelInterface {
    
    public var observeData: ((Result<[PresentationModel.ImageObject], Error>) -> ())?
    
    public init() {
        
    }
    
    public func downloadImages() {
        print("----")
        
    }
}
