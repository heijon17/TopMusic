//
//  FavouriteTrack+CoreDataProperties.swift
//  
//
//  Created by Jon-Martin Heiberg on 02/12/2019.
//
//

import Foundation
import CoreData


extension FavouriteTrack {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavouriteTrack> {
        return NSFetchRequest<FavouriteTrack>(entityName: "FavouriteTrack")
    }

    @NSManaged public var idAlbum: String
    @NSManaged public var idTrack: String
    @NSManaged public var intDuration: String
    @NSManaged public var strAlbum: String
    @NSManaged public var strArtist: String
    @NSManaged public var strName: String
    @NSManaged public var strThumb: String?

}
