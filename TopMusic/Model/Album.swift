//
//  Album.swift
//  TopMusic
//
//  Created by Jon-Martin Heiberg on 30/10/2019.
//  Copyright © 2019 JMHeiberg. All rights reserved.
//

import Foundation

struct RootAlbum: Decodable {
    var album: [Album]
    
    enum CodingKeys: String, CodingKey {
        case album = "album"
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.album = try values.decode([Album].self, forKey: CodingKeys.album)
    }
}

struct Album: Decodable, Loadable {
    var idAlbum: String
    var idArtist: String
    var strName: String
    var strArtist: String
    var intYearReleased: String
    var strGenre: String?
    var strThumb: String?
    
    enum CodingKeys: String, CodingKey {
        case idAlbum = "idAlbum"
        case idArtist = "idArtist"
        case strAlbum = "strAlbum"
        case strArtist = "strArtist"
        case intYearReleased = "intYearReleased"
        case strGenre = "strGenre"
        case strAlbumThumb = "strAlbumThumb"
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.idAlbum = try values.decode(String.self, forKey: CodingKeys.idAlbum)
        self.idArtist = try values.decode(String.self, forKey: CodingKeys.idArtist)
        self.strName = try values.decode(String.self, forKey: CodingKeys.strAlbum)
        self.strArtist = try values.decode(String.self, forKey: CodingKeys.strArtist)
        self.intYearReleased = try values.decode(String.self, forKey: CodingKeys.intYearReleased)
        self.strGenre = try values.decode(String?.self, forKey: CodingKeys.strGenre)
        self.strThumb = try values.decode(String?.self, forKey: CodingKeys.strAlbumThumb)
    }
}
