//
//  Initial.swift
//  TopMusic
//
//  Created by Jon-Martin Heiberg on 23/10/2019.
//  Copyright © 2019 JMHeiberg. All rights reserved.
//

import Foundation

struct Initial: Decodable {
    var tracks: [Track]
    
    enum CodingKeys: String, CodingKey {
        case tracks = "loved"
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.tracks = try values.decode([Track].self, forKey: CodingKeys.tracks)
    }
}
