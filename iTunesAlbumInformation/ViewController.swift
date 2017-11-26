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

    var artists: [Artist] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        ArtistTable.dataSource = self
        ArtistTable.delegate = self
        searchBar.delegate = self
        ArtistParse.main.getArtist(){_ in
            
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

extension ViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        ArtistParse.main.asd = searchText
        ArtistParse.main.getArtist { (artists) in
            self.artists = artists
            self.ArtistTable.reloadData()
        }
    }
}


extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    
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
