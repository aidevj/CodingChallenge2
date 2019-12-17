//
//  CollectionViewController.swift
//  CodingChallenge2
//
//  Created by Consultant on 12/14/19.
//  Copyright © 2019 MAC. All rights reserved.
//
//  NOTE: *Programatically* sets up collection view controller for Collection View

import UIKit

// Delegate for ListVC
protocol CollectionDelegate: class {
    func passInformation(image: UIImage)
}

class CollectionViewController: UIViewController {

//    @IBOutlet weak var albumLabel: UILabel!        // error
//    @IBOutlet weak var albumImage: UIImageView!    // error
    
    @IBOutlet weak var collectionView: UICollectionView!
//        = {
//        let layout = UICollectionViewFlowLayout()
//        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
//        cv.translatesAutoresizingMaskIntoConstraints = false
//        cv.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "CollecitonCell")
//        return cv
//    }()
    
    // For passing information to Image View Controller
    weak var delegate: CollectionDelegate?
    var imageVC: ImageViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollection()
    }
    
    //MARK: Functionality
    
    private func setupCollection() {
        //TODO
    }
    
    //MARK: Sort
    
    private func orderByAlbum() {
        
    }

}

extension CollectionViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    // Controls Height and width of each item
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 175, height: 200)  //TODO: get proper scale, dont hardcode for final
    }
    
    // Controls Number of items in section
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //TODO: return albums.count
        return 20
    }
    
    // Controls each cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCell", for: indexPath)
        
        return cell
    }
    
    //TODO: Organize by album number
    
    
}
