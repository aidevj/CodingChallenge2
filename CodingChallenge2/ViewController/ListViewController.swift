//
//  ViewController.swift
//  CodingChallenge2
//
//  Created by Consultant on 12/14/19.
//  Copyright © 2019 MAC. All rights reserved.
//
// Class for the main VC, displaying the song list in a table view

import UIKit

class ListViewController: UIViewController {

    @IBOutlet weak var listTableView: UITableView!
    
    //MARK: Properties
    
    var songs = [Song]() {
        didSet {
            //orderedSongs = order(songs)   // set ordered cities
            DispatchQueue.main.async {
                self.listTableView.reloadData()
            }
        }
    }
    
    var filteredSongs = [Song]()
    
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
        let song = songs[indexPath.row]
        cell.titleLabel.text = "\(song.title)"
        cell.albumIdLabel.text = "Album: \(song.albumId) | Track: \(song.id)"
        
        // TODO: change image to thumbnail from url
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
}

