//
//  ImageScreen.swift
//  PicsumImageViewer
//
//  Created by user on 21.03.2023.
//

import UIKit
import PresentationLayer
import SDWebImage

protocol ImageScreenDelegate: AnyObject {
    func closeScreen()
}

class ImageScreen: UIViewController {
    /// Navigation
    weak var coordinatorDelegate: ImageScreenDelegate?
    
    /// View Models
    var viewModel: ImageScreenViewModelInterface!
    /// UI Properties
    private lazy var label: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.numberOfLines = 0
        view.text = viewModel.labelData()
        return view
    }()
    
    private lazy var image: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var segmentController: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: ["Normal", "Blur", "Grayscale"])
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.selectedSegmentIndex = 0
       
        segmentedControl.addTarget(self, action: #selector(segmentedControlValueChanged(_:)), for: .valueChanged)

        return segmentedControl
    }()
    
    private lazy var slider: UISlider = {
        let slider = UISlider()
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.minimumValue = 1
        slider.maximumValue = 10
        slider.value = 1
        slider.isHidden = true
        slider.addTarget(self, action: #selector(sliderValueChanged(_:)), for: .touchUpInside)

        return slider
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initUIComponents()
        
        viewModel.observeImageURL = { [weak self] url in
            self?.image.sd_cancelCurrentImageLoad()
            self?.image.sd_setImage(with: url, placeholderImage: UIImage(systemName: "photo"))
        }
        
        // This line only for simulator, viewModel handle automatic loading, and on real device all work well
        viewModel.loadImage(type: .normal)
    }
    
    deinit {
        coordinatorDelegate?.closeScreen()
    }
    
    private func initUIComponents() {
        view.backgroundColor = .systemBackground
        title = "Image Details"
        
        view.addSubview(label)
        view.addSubview(image)
        view.addSubview(segmentController)
        
        view.addSubview(slider)
        
        label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30).isActive = true
        label.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
        label.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 10).isActive = true
        
        image.heightAnchor.constraint(equalToConstant: 200).isActive = true
        image.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 30).isActive = true
        image.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
        image.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10).isActive = true
        
        segmentController.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 30).isActive = true
        segmentController.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
        segmentController.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10).isActive = true
        
        slider.topAnchor.constraint(equalTo: segmentController.bottomAnchor, constant: 30).isActive = true
        slider.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
        slider.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10).isActive = true
    }
    
    @objc func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            slider.isHidden = true
            viewModel.loadImage(type: .normal)
        case 1:
            slider.isHidden = false
            viewModel.loadImage(type: .blur)
        case 2:
            slider.isHidden = true
            viewModel.loadImage(type: .graystyle)
        default:
            break
        }
    }
    
    @objc func sliderValueChanged(_ sender: UISlider) {
        let value = Int(sender.value)
        viewModel.changeImageBlur(density: value)
    }
}
