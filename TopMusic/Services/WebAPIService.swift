//
//  WebAPI.swift
//  TopMusic
//
//  Created by Jon-Martin Heiberg on 16/10/2019.
//  Copyright © 2019 JMHeiberg. All rights reserved.
//

import Foundation
import Alamofire

class WebAPIService {
    
    // The Alamofire code is inspired by the Lectures and Alamofire docs.
    // https://github.com/Alamofire/Alamofire/blob/master/Documentation/Usage.md#using-alamofire
    
    static func getAlbumSearch(albumName: String, completion: @escaping ([Album]?) -> Void) {
        AF.request("https://theaudiodb.com/api/v1/json/1/searchalbum.php?a=\(albumName)").responseJSON { (response) in
            if let json = response.data {
                do {
                    let jsonData = try JSONDecoder().decode(RootAlbum.self, from: json)
                    completion(jsonData.album)
                } catch let error {
                    print(error)
                    completion([])
                }
            }
        }
    }
    
    static func getAlbum(albumId: String, completion: @escaping ([Album]?) -> Void){
        AF.request("https://theaudiodb.com/api/v1/json/1/album.php?m=\(albumId)").responseJSON { (response) in
            if let json = response.data {
                do {
                    let jsonData = try JSONDecoder().decode(RootAlbum.self, from: json)
                    completion(jsonData.album)
                } catch let error {
                    print(error)
                }
            }
        }
    }
    
    static func getTracks(albumId: String?, completion: @escaping ([Track]?) -> Void){
        var loved = true
        var url = ""
        if let id = albumId {
            url = "https://theaudiodb.com/api/v1/json/1/track.php?m=\(id)"
            loved = false
        } else {
            url = "https://theaudiodb.com/api/v1/json/1/mostloved.php?format=track"
        }
        
        AF.request(url).responseJSON { (response) in
            if let json = response.data {
                do {
                    if loved {
                        let jsonData = try JSONDecoder().decode(RootLovedTracks.self, from: json)
                        completion(jsonData.tracks)
                    } else {
                        let jsonData = try JSONDecoder().decode(RootTracks.self, from: json)
                        completion(jsonData.tracks)
                    }
                    
                } catch let error {
                    print(error)
                }
            }
        }
    }
    
    static func getRecommendedArtists(favourites: [FavouriteTrack], completion: @escaping ([RecArtist]?) -> Void) {
        guard favourites.count != 0 else {
            completion([])
            return
        }
        var query = ""
        for favourite in favourites {
            query.append("\(favourite.strArtist),")
        }
        query.removeLast()
        let url = "https://tastedive.com/api/similar?q=\(query)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        
        AF.request(url).responseJSON { (response) in
            if let json = response.data {
                do {
                    let jsonData = try JSONDecoder().decode(RootRecArtist.self, from: json)
                    completion(jsonData.similar.results)
                } catch let error {
                    print(error)
                }
            }
        }
        
    }
    
    
}




