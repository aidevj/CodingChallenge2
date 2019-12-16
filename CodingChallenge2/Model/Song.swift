//
//  Song.swift
//  CodingChallenge2
//
//  Created by Consultant on 12/15/19.
//  Copyright © 2019 MAC. All rights reserved.
//
// Struct to define Songs to be loaded in the table view

import Foundation
import UIKit

struct Song {
    let title: String
    let imageUrl: String
    let thumbnailUrl: String
    let albumId: Int
    let id: Int
    let thumbnailImage: UIImage?  // can be nil if cannot find image from url
    let image: UIImage?           // full sized image, can als obe nil if cannot get image from url
}
