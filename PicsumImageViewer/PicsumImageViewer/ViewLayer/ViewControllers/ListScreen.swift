//
//  ListScreen.swift
//  PicsumImageViewer
//
//  Created by user on 21.03.2023.
//

import UIKit
import PresentationLayer

protocol ListScreenDelegate: AnyObject {
    func openImageScreen(image: PresentationModel.Image)
}

class ListScreen: UIViewController {
    /// Navigation
    weak var coordinatorDelegate: ListScreenDelegate?
    
    /// View Models
    var viewModel: ListScreenViewModelInterface!
    
    /// Data Properties
    private var data: Array<PresentationModel.Image> = Array() {
        didSet {
            var snapshot = NSDiffableDataSourceSnapshot<Section, PresentationModel.Image>()
            snapshot.appendSections([.main])
            snapshot.appendItems(data)
            dataSource.apply(snapshot)
        }
    }
    
    /// UI Properties
    enum Section {
        case main
    }
    
    private lazy var dataSource: UICollectionViewDiffableDataSource<Section, PresentationModel.Image> = {
        let dataSource = UICollectionViewDiffableDataSource<Section, PresentationModel.Image>(collectionView: collectionView) {
            collectionView, indexPath, data in
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ListCell.reuseIdentifier, for: indexPath) as! ListCell
            cell.loadImage(url: self.data[indexPath.row].url)
            
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
                self?.data += data
            case .failure(let error):
                self?.presentAlertController(msg: error.localizedDescription)
            }
        }
    }
    
    private func initUIComponents() {
        view.backgroundColor = .systemBackground
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
        coordinatorDelegate?.openImageScreen(image: data[indexPath.row])
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.item == self.data.count - 1 {
            self.viewModel.downloadImages()
        }
    }
}
