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

    static func getTracks(completion: @escaping ([Track]?) -> Void){
        AF.request("https://theaudiodb.com/api/v1/json/1/mostloved.php?format=track").responseJSON { (response) in
            if let json = response.data {
                do {
                    let jsonData = try JSONDecoder().decode(Initial.self, from: json)
                    completion(jsonData.tracks)
                } catch let error {
                    print(error)
                }
            }
        }
        
     
    }
}




