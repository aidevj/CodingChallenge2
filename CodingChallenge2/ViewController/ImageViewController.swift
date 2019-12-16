//
//  ImageViewController.swift
//  CodingChallenge2
//
//  Created by Consultant on 12/14/19.
//  Copyright © 2019 MAC. All rights reserved.
//
//  Used to display the full image of the selected song

import UIKit


class ImageViewController: UIViewController {

    @IBOutlet weak var fullImage: UIImageView!
    
    // Image to recieve from the delegate
    var receivedImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

// Conform to protocols for delegate
extension ImageViewController: ListDelegate {
    func passInformation(image: UIImage) {
        fullImage.image = image
    }
}

//TODO: conform to protocol for delegate from collection view as well (when I make it exist)

