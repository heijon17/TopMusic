//
//  WebAPI.swift
//  TopMusic
//
//  Created by Jon-Martin Heiberg on 16/10/2019.
//  Copyright © 2019 JMHeiberg. All rights reserved.
//

import Foundation
import Alamofire

class WebAPI {

    static func getMostLoved(completion: @escaping ([Track]?) -> Void){
        AF.request("https://theaudiodb.com/api/v1/json/1/mostloved.php?format=track").responseJSON { (response) in
            if let json = response.data {
                do {
                    let jsonData = try JSONDecoder().decode(RootTracks.self, from: json)
                    completion(jsonData.tracks)
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
    
    
}




