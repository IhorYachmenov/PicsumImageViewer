//
//  ListScreenViewModel.swift
//  PresentationLayer
//
//  Created by user on 21.03.2023.
//

import Foundation
import DomainLayer

public enum PresentationModel {
    public struct Image: Hashable {
        public let id: String
        public let url: String
        public let author: String
        public let height: Int
        public let width: Int
    }
}

extension PresentationModel.Image {
    init(data: DomainModel.Image) {
        self.id = data.id
        self.url = data.url
        self.author = data.author
        self.height = data.height
        self.width = data.width
    }
}

public protocol ListScreenViewModelInterface: AnyObject {
    func downloadImages()
    var observeData: ((Result<[PresentationModel.Image], Error>) -> ())? { get set }
}
