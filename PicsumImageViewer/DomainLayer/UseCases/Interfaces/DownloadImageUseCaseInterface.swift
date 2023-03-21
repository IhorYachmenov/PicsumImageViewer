//
//  DownloadImageUseCaseInterface.swift
//  DomainLayer
//
//  Created by user on 21.03.2023.
//

import Foundation

public enum DomainModel {
    public struct ImageObject {
        public let id: String
        public let url: String
        public let author: String
        public let height: String
        public let width: String
    }
}

public protocol DownloadImageUseCaseInterface: AnyObject {
    func downloadImages(page: Int)
    var observeData: ((Result<[DomainModel.ImageObject], Error>) -> ())? { get set }
}
