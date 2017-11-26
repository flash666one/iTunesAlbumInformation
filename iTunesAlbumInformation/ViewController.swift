//
//  ViewController.swift
//  iTunesAlbumInformation
//
//  Created by Артём Горюнов on 23.11.2017.
//  Copyright © 2017 Артём Горюнов. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var ArtistTable: UITableView!
    
    // пустой масим с объектами типа Artist
    var artists: [Artist] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        //настройка элемента navigationBar
        navigationItem.title = "Artist"
        //назначение параметров delegate и dataSource этого на класс данного VC
        ArtistTable.dataSource = self
        ArtistTable.delegate = self
        searchBar.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

extension ViewController: UISearchBarDelegate {
    //настройка функции парсера при наборе текста
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        RequestManager.main.getArtist(by: searchText) { (artists) in
            self.artists = artists
            self.ArtistTable.reloadData()
        }
    }
}


extension ViewController: UITableViewDelegate, UITableViewDataSource {
    //настройка таблицы, ячейка возвращает исполнителей, согласно вводимым значениям в поле searchBar
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "artist") as! ArtistResultTableViewCell
            cell.ArtistResult.text = self.artists[indexPath.row].artist
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return artists.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "albumVC") as? AlbumViewController {
            vc.object = artists[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}
