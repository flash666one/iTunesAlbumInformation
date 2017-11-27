//
//  AlbumViewController.swift
//  iTunesAlbumInformation
//
//  Created by Артём Горюнов on 23.11.2017.
//  Copyright © 2017 Артём Горюнов. All rights reserved.
//

import UIKit
import Alamofire

class AlbumViewController: UIViewController {
    //объект, принимаемый из предудущего контролера и пустой
    var object: Artist?
    var albums: [Album] = []
    
    @IBOutlet weak var albumCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "\(object!.artist)"
        albumCollectionView.delegate = self
        albumCollectionView.dataSource = self
        //вызываю функцию парсинга альбомов
        RequestManager.main.getAlbum(by: object!.artistId) { (albums) in
            self.albums = albums
            self.albumCollectionView.reloadData()
            self.albums.sort(by: { $0.album < $1.album })
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension AlbumViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = albumCollectionView.dequeueReusableCell(withReuseIdentifier: "album", for: indexPath) as! AlbumCollectionViewCell
        //извлекаю по url дату изображения и передаю на imageview ячейки
        let artwork = albums[indexPath.row].artwork
        if let url = URL(string: artwork) {
            let dataTask = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
                if let imageData = data {
                    if let image = UIImage(data: imageData) {
                        DispatchQueue.main.async {
                            cell.albumArtImage.layer.masksToBounds = true
                            cell.albumArtImage.layer.cornerRadius = 5
                            cell.albumArtImage.layer.borderColor = UIColor.black.cgColor
                            cell.albumArtImage.layer.borderWidth = 1
                            cell.albumArtImage.image = image
                        }
                    }
                }
            })
            dataTask.resume()
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return albums.count
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "tracklist") as? AlbumTracklist {
            vc.object = albums[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}


