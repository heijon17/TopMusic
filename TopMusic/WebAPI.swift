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

    func getTracks(completed:@escaping (_ tracks: [Track]) -> Void) {
        guard let url = URL(string: "https://theaudiodb.com/api/v1/json/1/mostloved.php?format=track")
            else {return}
        AF.request(url, method: .get).responseJSON { (response) in
            guard let data = response.data else {return}
            
            do{
                let myResponse = try JSONDecoder().decode([Track].self, from: data)
                completed(myResponse)
            } catch {}
        }
    }
}




