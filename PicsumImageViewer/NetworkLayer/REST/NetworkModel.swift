//
//  NetworkModel.swift
//  NetworkLayer
//
//  Created by user on 21.03.2023.
//

import Foundation

public enum NetworkModel {
    public struct Image: Decodable {
        public let id: String?
        public let author: String?
        public let width: Int?
        public let height: Int?
        public let url: String?
        public let downloadUrl: String?
    }
}
