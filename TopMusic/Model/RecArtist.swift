//
//  RecArtist.swift
//  TopMusic
//
//  Created by Jon-Martin Heiberg on 04/12/2019.
//  Copyright © 2019 JMHeiberg. All rights reserved.
//

import Foundation

struct RootRecArtist: Decodable {
    var similar: RecResults
    
    enum CodingKeys: String, CodingKey {
        case similar = "Similar"
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.similar = try values.decode(RecResults.self, forKey: .similar)
    }
}

struct RecResults: Decodable {
    var results: [RecArtist]
    
    enum CodingKeys: String, CodingKey {
        case results = "Results"
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.results = try values.decode([RecArtist].self, forKey: .results)
    }
}

struct RecArtist: Decodable {
    var name: String
    var type: String
    
    enum CodingKeys: String, CodingKey {
        case name = "Name"
        case type = "Type"
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try values.decode(String.self, forKey: .name)
        self.type = try values.decode(String.self, forKey: .type)
   }
}



