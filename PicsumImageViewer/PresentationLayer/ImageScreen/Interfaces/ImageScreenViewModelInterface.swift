//
//  ImageScreenViewModelInterface.swift
//  PresentationLayer
//
//  Created by user on 22.03.2023.
//

import Foundation

extension PresentationModel {
    public enum ImageType {
        case normal, blur, graystyle
        
        func value() -> String {
            switch self {
            case .normal:
                return ""
            case .blur:
                return "?blur="
            case .graystyle:
                return "?grayscale"
            }
        }
    }
}

public protocol ImageScreenViewModelInterface: AnyObject {
    var observeImageURL: ((URL) -> ())? { get set }
    func labelData() -> String
    func loadImage(type: PresentationModel.ImageType)
    func changeImageBlur(density: Int)
}
