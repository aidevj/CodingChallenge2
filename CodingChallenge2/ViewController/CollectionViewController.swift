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
    
    // Array of ordered songs with observer
    var orderedSongs: [String: [Song]] = [:] {
        didSet {
            DispatchQueue.main.async{
                self.collectionView.reloadData()
            }
        }
    }
    
    // Hold array of songs
    var songs = [Song]() {
        didSet {
            //orderedSongs = order(songs)   //TODO: Need to implement and call orderbyAlbum()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollection()
    }
    
    //MARK: Functionality
    
    // Used to get the list of songs using SongManager singleton
    private func get() {
        SongManager.shared.getSongs { [weak self] sngs in
            self?.songs = sngs
            print("Song count (collection view): \(sngs.count)")
        }
    }
    
    // To be called in viewDidLoad() - sets up loaded songs on Table View
    private func setupCollection() {
        get()
        
        // Register XIB Cell View to collection view
        //collectionView.register(UINib(nibName: "CollectionCell", bundle: Bundle.main), forCellReuseIdentifier: "CollectionCell")
    }
    
    //MARK: Sort
    
    private func orderByAlbum() {
        //TODO
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
        return songs.count
    }
    
    // Controls each cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCell", for: indexPath)
        
        return cell
    }
    
    //TODO: Organize by album number
    
    
}
