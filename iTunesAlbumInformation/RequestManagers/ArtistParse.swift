//
//  iTunesProtocol.swift
//  iTunesAlbumInformation
//
//  Created by Артём Горюнов on 23.11.2017.
//  Copyright © 2017 Артём Горюнов. All rights reserved.
//

import Foundation
import Alamofire

class ArtistParse {

    static let main = ArtistParse()
    var asd = "Swift"

    func getArtist (completion: @escaping ([Artist]) -> ()) {
        let link = "https://itunes.apple.com/search?term=\(asd)&entity=musicArtist"
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
}
