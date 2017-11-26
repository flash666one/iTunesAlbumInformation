//
//  AlbumSonglistParse.swift
//  iTunesAlbumInformation
//
//  Created by Артём Горюнов on 24.11.2017.
//  Copyright © 2017 Артём Горюнов. All rights reserved.
//

import Foundation
import Alamofire

class TracklistParse {
    
    static let main = TracklistParse()
    var asd = 0
    
    func getTracklist (completion: @escaping ([Tracklist]) -> ()) {
        let link = "https://itunes.apple.com/lookup?id=\(asd)&entity=song"
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
