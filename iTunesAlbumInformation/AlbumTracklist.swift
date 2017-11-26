//
//  AlbumTracklist.swift
//  iTunesAlbumInformation
//
//  Created by Артём Горюнов on 24.11.2017.
//  Copyright © 2017 Артём Горюнов. All rights reserved.
//
import Foundation
import UIKit

class AlbumTracklist: UIViewController {
    
    @IBOutlet weak var albumTracklist: UITableView!
    
    var object: Album?
    var tracklist: [Tracklist] = []
    
    @IBOutlet weak var albumArt: UIImageView!
    
    @IBOutlet weak var albumName: UILabel!
    
    @IBOutlet weak var artistName: UILabel!
    
    @IBOutlet weak var yearGenreLabel: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        TracklistParse.main.asd = (object?.collectionId)!
        TracklistParse.main.getTracklist { (tracks) in
            self.tracklist = tracks
            self.albumTracklist.reloadData()
        }
        albumTracklist.dataSource = self
        albumArt.layer.masksToBounds = true
        if let url = URL(string: (object?.artwork)!) {
            let dataTask = URLSession.shared.dataTask(with: url, completionHandler: myHandler)
            dataTask.resume()
        }
        albumName.text = object?.album
        artistName.text = object?.artistName
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let date = dateFormatter.date(from: (object?.year)!)!
        dateFormatter.dateFormat = "yyyy"
        let dateString = dateFormatter.string(from: date)
        
        yearGenreLabel.text = (object?.genre)! + " ・ " + dateString
        
    }
    
    func myHandler(data: Data?, response: URLResponse?, error: Error?) {
        if let imageData = data {
            if let image = UIImage(data: imageData) {
                DispatchQueue.main.async {
                    self.albumArt.image = image
                    
                }
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension AlbumTracklist: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = albumTracklist.dequeueReusableCell(withIdentifier: "song") as! SongTableViewCell
            cell.songInfo.text = tracklist[indexPath.row].trackName
            cell.songNumber.text = String(tracklist[indexPath.row].trackNumber)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tracklist.count
    }
}
