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
    var tracks: [Tracklist] = []
    
    @IBOutlet weak var albumArt: UIImageView!
    
    @IBOutlet weak var albumName: UILabel!
    
    @IBOutlet weak var artistName: UILabel!
    
    @IBOutlet weak var yearGenreLabel: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        //вызываю функцию парсера
        RequestManager.main.getTracklist(by: object!.collectionId) { (tracks) in
            self.tracks = tracks
            self.albumTracklist.reloadData()
        }
        //назначаю dataSource на таблицу с треками
        albumTracklist.dataSource = self
        // извлекаю обложку альбома по url передаю на imageView
        albumArt.layer.masksToBounds = true
        if let url = URL(string: object!.artwork) {
            let dataTask = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
                if let imageData = data {
                    if let image = UIImage(data: imageData) {
                        DispatchQueue.main.async {
                            self.albumArt.image = image
                            
                        }
                    }
                }
            })
            dataTask.resume()
        }
        //парсинг названия альбома и имени артиста
        albumName.text = object?.album
        artistName.text = object?.artistName
        
        //для парсинга даты нужна конвертация конвертирую из того что приходит в json в string
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let date = dateFormatter.date(from: object!.year)!
        dateFormatter.dateFormat = "yyyy"
        let dateString = dateFormatter.string(from: date)
        //передаю на label
        yearGenreLabel.text = object!.genre + "・" + dateString
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
//настройка таблицы с треками
extension AlbumTracklist: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = albumTracklist.dequeueReusableCell(withIdentifier: "song") as! SongTableViewCell
            cell.songInfo.text = tracks[indexPath.row].trackName
            cell.songNumber.text = String(tracks[indexPath.row].trackNumber)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tracks.count
    }
}
