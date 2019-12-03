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

// Inspired by https://medium.com/@ankurvekariya/core-data-crud-with-swift-4-2-for-beginners-40efe4e7d1cc

class CoreDataService {
    static private let moc =  (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    static func favourites(completion: @escaping ([FavouriteTrack]?) -> Void ) {
        
        let fetchRequest: NSFetchRequest<FavouriteTrack> = FavouriteTrack.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "position", ascending: true)]
        do {
               completion(try moc.fetch(fetchRequest))
           } catch let error as NSError {
               print("Failed to fetch. \(error), \(error.userInfo)")
           }
    }
    
    static func remove(itemToRemove: NSManagedObject) throws {
        moc.delete(itemToRemove)
        try moc.save()
    }
    
    static func add(track: Track, index: Int) throws {
        let entity = NSEntityDescription.entity(forEntityName: "FavouriteTrack", in: moc)
        let newFavouriteTrack = FavouriteTrack(entity: entity!, insertInto: moc)
        
        newFavouriteTrack.setValue(index, forKey: "position")
        newFavouriteTrack.setValue(track.idAlbum, forKey: "idAlbum")
        newFavouriteTrack.setValue(track.idTrack, forKey: "idTrack")
        newFavouriteTrack.setValue(track.intDuration, forKey: "intDuration")
        newFavouriteTrack.setValue(track.strAlbum, forKey: "strAlbum")
        newFavouriteTrack.setValue(track.strArtist, forKey: "strArtist")
        newFavouriteTrack.setValue(track.strName, forKey: "strName")
        newFavouriteTrack.setValue(track.strThumb, forKey: "strThumb")
        
        try moc.save()
    }
    
    static func updateOrder(tracks: [FavouriteTrack]) throws {
        do {
            let results = try moc.fetch(FavouriteTrack.fetchRequest()) as [FavouriteTrack]
            for track in results {
                for favourite in tracks {
                    if (track.idTrack == favourite.idTrack) {
                        track.setValue(tracks.firstIndex(of: favourite), forKey: "position")
                    }
                }
            }
        } catch {
            print("Failed to update...")
        }

        try moc.save()
    }
    

    
}
