//
//  ImageTableCell.swift
//  CodingChallenge2
//
//  Created by Consultant on 12/15/19.
//  Copyright © 2019 MAC. All rights reserved.
//

import UIKit

class ImageTableCell: UITableViewCell {

    // Outlets for elements of cell
    @IBOutlet weak var thumbnail: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var albumIdLabel: UILabel!
    
    static let identifier = "ImageTableCell"
}
