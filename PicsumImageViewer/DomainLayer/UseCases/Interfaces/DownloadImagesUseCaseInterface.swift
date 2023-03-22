//
//  DownloadImageUseCaseInterface.swift
//  DomainLayer
//
//  Created by user on 21.03.2023.
//

import Foundation
import NetworkLayer

public enum DomainModel {
    public struct Image {
        public let id: String
        public let url: String
        public let author: String
        public let height: Int
        public let width: Int
    }
}

extension DomainModel.Image {
    init(data: NetworkModel.Image) {
        self.id = data.id.isNil()
        self.url = data.downloadUrl.isNil()
        self.author = data.author.isNil()
        self.height = data.height.isNil()
        self.width = data.width.isNil()
    }
}
public protocol DownloadImagesUseCaseInterface: AnyObject {
    var observeData: ((Result<[DomainModel.Image], Error>) -> ())? { get set }
    func downloadImages(page: Int)
}
