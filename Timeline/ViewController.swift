//
//  ViewController.swift
//  Timeline
//
//  Created by Paul Ossenbruggen on 5/23/20.
//  Copyright © 2020 Paul Ossenbruggen. All rights reserved.
//

import UIKit

class ViewController: UICollectionViewController {
    let modelController = ModelController()

    override func viewDidLoad() {
        super.viewDidLoad()
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 7
        layout.itemSize = CGSize(width: 500, height: 500)
        collectionView.collectionViewLayout = layout
        collectionView.delegate = modelController
        collectionView.dataSource = modelController
        modelController.load()
    }
    
}

