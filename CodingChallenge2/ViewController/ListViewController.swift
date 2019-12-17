//
//  ViewController.swift
//  CodingChallenge2
//
//  Created by Consultant on 12/14/19.
//  Copyright © 2019 MAC. All rights reserved.
//
// Class for the main VC, displaying the song list in a table view

import UIKit

// Delegate for ListVC
protocol ListDelegate: class {
    func passInformation(image: UIImage)
}

class ListViewController: UIViewController {

    @IBOutlet weak var listTableView: UITableView!

    //MARK: Properties
    
    // For passing information to Image View Controller
    weak var delegate: ListDelegate?
    var imageVC: ImageViewController!
    
    // Array of ordered songs with observer
    var orderedSongs: [String: [Song]] = [:] {
        didSet {
            DispatchQueue.main.async{
                self.listTableView.reloadData()
            }
        }
    }
    
    // Hold array of songs
    var songs = [Song]() {
        didSet {
            orderedSongs = order(songs)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupList()
    }
    
    //MARK: Functionality
    
    // Used to get the list of songs using SongManager singleton
    private func get() {
        SongManager.shared.getSongs { [weak self] sngs in
            self?.songs = sngs
            print("Song count: \(sngs.count)")
        }
    }
    
    // To be called in viewDidLoad() - sets up loaded songs on Table View
    private func setupList() {
        get()
        
        // Register XIB Cell View to list table view
        listTableView.register(UINib(nibName: ImageTableCell.identifier, bundle: Bundle.main), forCellReuseIdentifier: ImageTableCell.identifier)
        
        // remove unused table cells
        listTableView.tableFooterView = UIView(frame: .zero)
    }
    
    //MARK: Sorting
    
    // Sort array of songs into ABC order by title
    private func order(_ songs: [Song]) -> [String: [Song]] {
        
        var songsDict = Dictionary(grouping: songs, by: {$0.title.first!.uppercased()})
        
        // loop through songs dictionary, sort the song array for each key into ABC order
        for (key, value) in songsDict {
            songsDict[key] = value.sorted(by: { (songOne, songTwo) -> Bool in
                songOne.title < songTwo.title
            })
        }
        
        return songsDict
    }
    
    // helper function
    private func getSongs(from section: Int) -> [Song] {    // not being used?
        // put keys in ascending order
        let keys = orderedSongs.keys.sorted(by: {$0 < $1})
        let key = keys[section] // get correct key from section
        return orderedSongs[key]!
    }

}

// extension to handle table view elements
extension ListViewController: UITableViewDataSource, UITableViewDelegate {

    // Set the number of rows in the table
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songs.count
    }
    
    // Set values and renders cells
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: ImageTableCell.identifier, for: indexPath) as! ImageTableCell
        
        // Change infomation for each cell here
        let songs = getSongs(from: indexPath.section)   // needed in order to order the titles
        let song = songs[indexPath.row]
        cell.titleLabel.text = "\(song.title)"
        cell.albumIdLabel.text = "Album: \(song.albumId) | Track: \(song.id)"
        
        
        // TRY
//        DispatchQueue.global(qos: .background).async {
//            guard let url = URL(string:song.thumbnailUrl) else {return}
//
//            guard let data = try? Data(contentsOf: url) else {return }
//
//            guard let image: UIImage = UIImage(data: data) else {return }
//
//            DispatchQueue.main.async {
//                cell.thumbnail.image = image
//            }
//        }
        
        // Change image to thumbnail from url
        //if let thumbnailImage = song.thumbnailImage {
        if song.thumbnailImage != nil {
            cell.thumbnail.image = song.thumbnailImage
        } // else will keep thumbnail as default X image
        
        return cell
    }
    
    // Control constant height for cell rows
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    // Control Touch Events on table view cells
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let song =  songs[indexPath.row]
        
        // Deselect after tap
        tableView.deselectRow(at: indexPath, animated: true)
        
        // Present Image View Controller of corresponding song image
        imageVC = (storyboard?.instantiateViewController(identifier: "ImageViewController") as! ImageViewController) // bad WARNING
        
        // Send information of cell clicked on (full image from URL)
        if let fullImage = song.image {
            delegate?.passInformation(image: fullImage)
        } else {
            print("Full Image is nil.")
        }
        
        present(imageVC, animated: true, completion: nil)
    }

    //TODO: Uncomment when get section headers to work
//    // Controls ABC sidebar, getting keys from dictionary
//    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
//        return orderedSongs.keys.sorted(by: {$0 < $1})
//    }
    
    //TODO: fix
//    // Controls headers for each section of table view
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        let keys = orderedSongs.keys.sorted(by: {$0 < $1})
//        return keys[section]  // index out of range error?
//    }
    
}

