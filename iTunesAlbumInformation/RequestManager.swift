//
//  RequestManager.swift
//  iTunesAlbumInformation
//
//  Created by Артём Горюнов on 26.11.2017.
//  Copyright © 2017 Артём Горюнов. All rights reserved.
//

import Foundation
import Alamofire

class RequestManager {
    
    static let main = RequestManager()
    
    //функция для парсинга исполнителя
    
    func getArtist (by name: String, completion: @escaping ([Artist]) -> ()) {
        let link = "https://itunes.apple.com/search?term=\(name)&entity=musicArtist"
        Alamofire.request(link).responseJSON { (response) in
            if let artists = response.result.value as? [String: Any] {
                if let array = artists["resultCount"] as? Int {
                    print(array)
                }
                if let array = artists["results"] as? [Any] {
                    completion(self.parseArtist(unparsed: array))
                    print(array)
                }
            }
        }
    }
    
    func parseArtist (unparsed artists: [Any]) -> [Artist] {
        var reloadArtists: [Artist] = []
        for artist in artists {
            var newArtist = Artist(artist: "", artistId: 0 , genre: "")
            if let dict = artist as? [String: Any] {
                if let artist = dict["artistName"] as? String {
                    newArtist.artist = artist
                }
                if let artistId = dict["artistId"] as? Int {
                    newArtist.artistId = artistId
                }
                // для парсинга альблмов
                if let genre = dict["primaryGenreName"] as? String {
                    newArtist.genre = genre
                }
            }
            reloadArtists.append(newArtist)
        }
        return reloadArtists
    }
    
    //функция для парсинга альбома
    
    func getAlbum (by id: Int, completion: @escaping ([Album]) -> ()) {
        let link = "https://itunes.apple.com/lookup?id=\(id)&entity=album"
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
    
    //функция для парсинга треклиста
    
    func getTracklist (by id: Int, completion: @escaping ([Tracklist]) -> ()) {
        let link = "https://itunes.apple.com/lookup?id=\(id)&entity=song"
        Alamofire.request(link).responseJSON { (response) in
            if let artists = response.result.value as? [String: Any] {
                if let array = artists["resultCount"] as? Int {
                    print(array)
                }
                if let array = artists["results"] as? [Any] {
                    completion(self.parseTracklist(unparsed: array))
                    print(array)
                }
            }
        }
    }
    
    func parseTracklist (unparsed tracks: [Any]) -> [Tracklist] {
        var reloadTracklist: [Tracklist] = []
        for track in tracks {
            var newTrack = Tracklist(trackNumber: 0, artistName: "", trackName: "")
            if let dict = track as? [String: Any] {
                
                if let trackNumber = dict["trackNumber"] as? Int {
                    newTrack.trackNumber = trackNumber
                }
                if let artist = dict["artistName"] as? String {
                    newTrack.artistName = artist
                }
                if let trackName = dict["trackName"] as? String {
                    newTrack.trackName = trackName
                }
            }
            if newTrack.trackNumber != 0 {
                reloadTracklist.append(newTrack)
                
            }
        }
        return reloadTracklist
    }
    
}
