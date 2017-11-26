//
//  AlbumParse.swift
//  iTunesAlbumInformation
//
//  Created by Артём Горюнов on 24.11.2017.
//  Copyright © 2017 Артём Горюнов. All rights reserved.
//

import Foundation
import Alamofire

class AlbumParse {
    
    static let main = AlbumParse()
    var asd = 0
    
    func getAlbum (completion: @escaping ([Album]) -> ()) {
        let link = "https://itunes.apple.com/lookup?id=\(asd)&entity=album"
        Alamofire.request(link).responseJSON { (response) in
            if let artists = response.result.value as? [String: Any] {
                if let array = artists["resultCount"] as? Int {
                    print(array)
                    
                }
                if let array = artists["results"] as? [Any] {
                    completion(self.parseAlbum(unparsed: array))
                    print(array)
                    
                }
            }
        }
    }
    
    func parseAlbum (unparsed albums: [Any]) -> [Album] {
        var reloadAlbums: [Album] = []
        for album in albums {
            var newAlbum = Album(artwork: "", album: "", artistName: "", year: "", genre: "" , collectionId: 0)
            if let dict = album as? [String: Any] {
                if let artwork = dict["artworkUrl100"] as? String {
                    newAlbum.artwork = artwork
                }
                if let album = dict["collectionName"] as? String {
                    newAlbum.album = album
                }
                if let artistName = dict["artistName"] as? String {
                    newAlbum.artistName = artistName
                }
                if let year = dict["releaseDate"] as? String {
                    newAlbum.year = year
                }
                if let genre = dict["primaryGenreName"] as? String {
                    newAlbum.genre = genre
                }
                if let collectionId = dict["collectionId"] as? Int {
                    newAlbum.collectionId = collectionId
                }
                
            }
            if newAlbum.artwork != "" {
                reloadAlbums.append(newAlbum)
                
            }
        }
        return reloadAlbums
    }
}
