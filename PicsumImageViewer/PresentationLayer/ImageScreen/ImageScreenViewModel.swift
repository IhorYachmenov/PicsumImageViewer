//
//  ImageScreenViewModel.swift
//  PresentationLayer
//
//  Created by user on 22.03.2023.
//

import Foundation

public final class ImageScreenViewModel: ImageScreenViewModelInterface {
    public var observeImage: ((URL) -> ())?
    
    private let image: PresentationModel.Image
    private var blurDensity = 1
    
    public init(image: PresentationModel.Image) {
        self.image = image
        DispatchQueue.main.async { [weak self] in
            self?.loadImage(type: .normal)
        }
    }
    
    public func labelData() -> String {
        let string = "Image ID: \(image.id), Author: \(image.author), H: \(image.height), W: \(image.width)"
        return string
    }
    
    public func loadImage(type: PresentationModel.ImageType) {
        let url = URL(string: createURLPath(type: type))!
        observeImage?(url)
    }
    
    public func loadImage(blurDensity: Int) {
        self.blurDensity = blurDensity
        let string = createURLPath(type: .blur)
        print(string)
        let url = URL(string: string)!
        
        observeImage?(url)
    }
    
    private func createURLPath(type: PresentationModel.ImageType) -> String {
        switch type {
        case .normal:
            return "\(image.url)\(type.value())"
        case .blur:
            return "\(image.url)\(type.value())\(blurDensity)"
        case .graystyle:
            return "\(image.url)\(type.value())"
        }
    }
}
