//
//  CoreData.swift
//  TopMusic
//
//  Created by Jon-Martin Heiberg on 03/12/2019.
//  Copyright © 2019 JMHeiberg. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class CoreDataService {
    static private let moc =  (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    static func favourites(completion: @escaping ([FavouriteTrack]?) -> Void ) {
        do {
               completion(try moc.fetch(FavouriteTrack.fetchRequest()))
           } catch let error as NSError {
               print("Failed to fetch. \(error), \(error.userInfo)")
           }
    }
    
    static func remove(at index: Int, itemToRemove: NSManagedObject) throws {
        moc.delete(itemToRemove)
        try moc.save()
    }
    
    static func add(track: Track) throws {
        let entity = NSEntityDescription.entity(forEntityName: "FavouriteTrack", in: moc)
        let newFavouriteTrack = FavouriteTrack(entity: entity!, insertInto: moc)
        
        newFavouriteTrack.setValue(track.idAlbum, forKey: "idAlbum")
        newFavouriteTrack.setValue(track.idTrack, forKey: "idTrack")
        newFavouriteTrack.setValue(track.intDuration, forKey: "intDuration")
        newFavouriteTrack.setValue(track.strAlbum, forKey: "strAlbum")
        newFavouriteTrack.setValue(track.strArtist, forKey: "strArtist")
        newFavouriteTrack.setValue(track.strName, forKey: "strName")
        newFavouriteTrack.setValue(track.strThumb, forKey: "strThumb")
        
        try moc.save()
        
    }
    

    
}
