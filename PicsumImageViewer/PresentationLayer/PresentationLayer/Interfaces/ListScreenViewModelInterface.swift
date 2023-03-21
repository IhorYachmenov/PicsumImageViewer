//
//  ListScreenViewModel.swift
//  PresentationLayer
//
//  Created by user on 21.03.2023.
//

import Foundation

public enum PresentationModel {
    public struct ImageObject: Hashable {
        public let url: URL
        public let data: Data
    }
}

public protocol ListScreenViewModelInterface: AnyObject {
    func downloadImages()
    var observeData: ((Result<[PresentationModel.ImageObject], Error>) -> ())? { get set }
}
