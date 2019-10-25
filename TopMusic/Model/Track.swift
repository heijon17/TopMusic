//
//  Album.swift
//  TopMusic
//
//  Created by Jon-Martin Heiberg on 16/10/2019.
//  Copyright © 2019 JMHeiberg. All rights reserved.
//

struct Track: Decodable {
    var strArtist: String
    var idTrack: String
    var strTrack: String
    var idAlbum: String
    var strAlbum: String
    var intDuration: String
    var strTrackThumb: String?
    
    enum CodingKeys: String, CodingKey {
        case strArtist = "strArtist"
        case idTrack = "idTrack"
        case strTrack = "strTrack"
        case idAlbum = "idAlbum"
        case strAlbum = "strAlbum"
        case intDuration = "intDuration"
        case strTrackThumb = "strTrackThumb"
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.strArtist = try values.decode(String.self, forKey: .strArtist)
        self.idTrack = try values.decode(String.self, forKey: .idTrack)
        self.strTrack = try values.decode(String.self, forKey: .strTrack)
        self.idAlbum = try values.decode(String.self, forKey: .idAlbum)
        self.strAlbum = try values.decode(String.self, forKey: .strAlbum)
        self.intDuration = try values.decode(String.self, forKey: .intDuration)
        self.strTrackThumb = try values.decode(String?.self, forKey: .strTrackThumb)
    }
}
