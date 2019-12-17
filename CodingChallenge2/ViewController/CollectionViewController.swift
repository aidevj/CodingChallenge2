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
        // adds the collection view programatically to the view controller
        //view.addSubview(collectionView)
        
        // set delegate and dataSource connections
        //collectionView.delegate = self
        //collectionView.dataSource = self
    }

}

extension CollectionViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    // Controls Height and width of each item
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width/2.5, height: collectionView.frame.width/2.5)
    }
    
    // Controls Number of items in section
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        3
    }
    
    // Controls each cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCell", for: indexPath)
        
        cell.backgroundColor = .red
        
        return cell
    }
    
    
}
