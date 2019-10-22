//
//  Album.swift
//  TopMusic
//
//  Created by Jon-Martin Heiberg on 16/10/2019.
//  Copyright © 2019 JMHeiberg. All rights reserved.
//

struct Track: Codable {
    var artist: String
    var trackId: Int
    var trackName: String
    var albumId: Int
    var albumName: String
    var duration: Int
    var trackThumb: String
}
