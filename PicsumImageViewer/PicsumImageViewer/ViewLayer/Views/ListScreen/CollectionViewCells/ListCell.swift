//
//  ListCell.swift
//  PicsumImageViewer
//
//  Created by user on 21.03.2023.
//

import UIKit

class ListCell: UICollectionViewCell {
    static let reuseIdentifier = "list-cell-reuse-identifier"
    
    let image: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = UIImage(systemName: "person.and.background.dotted")
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.cornerRadius = 10
        return view
    }()
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        initUIComponents()
    }
    required init?(coder: NSCoder) {
        fatalError("not implemented")
    }
    
    private func initUIComponents() {
        contentView.addSubview(image)

        let inset = CGFloat(10)
        
        image.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0).isActive = true
        image.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset).isActive = true
        image.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset).isActive = true
        image.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -inset).isActive = true
        
    }
}
