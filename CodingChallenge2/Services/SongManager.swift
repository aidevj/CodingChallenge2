//
//  SongManager.swift
//  CodingChallenge2
//
//  Created by Consultant on 12/15/19.
//  Copyright © 2019 MAC. All rights reserved.
//
//  This script is used to get the song elements data from a json file.
//  It should be a Singleton.

import Foundation
import UIKit

typealias SongHandler = ([Song]) -> Void

final class SongManager {
    
    static let shared = SongManager()
    
    private init () {}
    
    // function to get the list of elements from json file and store in a container
    // Using "songslist.json" file
    func getSongs(completion: @escaping SongHandler) {
        guard let path = Bundle.main.path(forResource: "songslist", ofType: "json") else {
            completion([])
            return
        }
        
        // Container to hold songs
        var songs = [Song]()
        
        DispatchQueue.global().async {
            // create URL from path made above
            let url = URL(fileURLWithPath: path)
            do {
                let data = try Data(contentsOf: url)
                let songsDict = try JSONSerialization.jsonObject(with: data, options: []) as! [[String:Any]]
                
                // loop through dictionaries and init
                for dict in songsDict {
                    guard let title = dict["title"] as? String,
                        let imageUrl = dict["url"] as? String,
                        let thumbnailUrl = dict["thumbnailUrl"] as? String,
                        let albumId = dict["albumId"] as? Int,
                        let id = dict["id"] as? Int else { continue }
                    
                    let thumbnailConvert = URL(string: thumbnailUrl)  // maybe do this in extension of Song init??
                    var thumbnailImage: UIImage?
                    
                    let imageConvert = URL(string: imageUrl)
                    var image: UIImage?
                    
                    // Get thumbnail image from URL
                    let thumbTask = URLSession.shared.dataTask(with: thumbnailConvert!) { data, response, error in
                        guard let data = data else { return }
                        
                        DispatchQueue.main.async() {
                            thumbnailImage = UIImage(data: data)
                        }
                    }
                    thumbTask.resume()  //TODO FIX: only returning nil
                    
                    let imageTask = URLSession.shared.dataTask(with: imageConvert!) { data, response, error in
                        guard let data = data else { return }
                        
                        DispatchQueue.main.async() {
                            image = UIImage(data: data)
                        }
                    }
                    imageTask.resume()  //TODO FIX: only returning nil
                    
                    
                    // init song
                    let song = Song(title: title, imageUrl: imageUrl, thumbnailUrl: thumbnailUrl, albumId: albumId, id: id, thumbnailImage: thumbnailImage, image: image)
                    
                    // append to array of songs
                    songs.append(song)
                }
                
                // call completion to add songs array
                completion(songs)
            } catch {
                // if fails, pass empty array to completion and exit
                completion([])
                print("Couldn't serialize JSON: \(error.localizedDescription)")
                return
            }
        } // end dispatch queue
    } // end func
    
}
