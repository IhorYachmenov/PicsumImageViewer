//
//  ListScreen.swift
//  PicsumImageViewer
//
//  Created by user on 21.03.2023.
//

import UIKit
import PresentationLayer

protocol ListScreenDelegate: AnyObject {
    func openImageScreen()
}

class ListScreen: UIViewController {
    /// Navigation
    weak var coordinatorDelegate: ListScreenDelegate?
    
    /// View Models
    var viewModel: ListScreenViewModelInterface!
    
    /// Data Properties
    private var data: Array<PresentationModel.ImageObject> = Array() {
        didSet {
            var snapshot = NSDiffableDataSourceSnapshot<Section, PresentationModel.ImageObject>()
            snapshot.appendSections([.main])
            snapshot.appendItems(data)
            dataSource.apply(snapshot)
        }
    }
    
    /// UI Properties
    enum Section {
        case main
    }
    
    private lazy var dataSource: UICollectionViewDiffableDataSource<Section, PresentationModel.ImageObject> = {
        let dataSource = UICollectionViewDiffableDataSource<Section, PresentationModel.ImageObject>(collectionView: collectionView) {
            collectionView, indexPath, data in
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ListCell.reuseIdentifier, for: indexPath) as! ListCell
//            cell.image.image = UIImage(data: self.data[indexPath.row].data)
            
            return cell
        }
        
        return dataSource
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .systemBackground
        collectionView.register(ListCell.self, forCellWithReuseIdentifier: ListCell.reuseIdentifier)
        
        collectionView.delegate = self
        
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initUIComponents()
        
        viewModel.observeData = { [weak self] result in
            switch result {
            case .success(let data):
                self?.data = data
                print(data.count)
            case .failure(let error):
                self?.presentAlertController(msg: error.localizedDescription)
            }
        }
        
    }
    
    private func initUIComponents() {
        view.backgroundColor = .white
        title = "Picsum"
        view.addSubview(collectionView)
    }
    
    private func createLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .absolute(200))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                       subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        return layout
    }
    
}

extension ListScreen: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        coordinatorDelegate?.openImageScreen()
        print("Selected index \(indexPath.row)")
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.item == data.count - 1 {
//            viewModel.downloadImages()
        }
    }
}
