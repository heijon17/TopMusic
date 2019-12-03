//
//  FavouritesTableViewController.swift
//  TopMusic
//
//  Created by Jon-Martin Heiberg on 28/11/2019.
//  Copyright © 2019 JMHeiberg. All rights reserved.
//

import UIKit
import CoreData

class FavouritesTableViewController: UITableViewController {
    
    private var favourites = [FavouriteTrack]()
    private var selectedTrack: FavouriteTrack?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        CoreDataService.favourites(completion: { results in
            if let tracks = results {
                self.favourites = tracks
                self.tableView.reloadData()
            }
        })
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favourites.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavouriteCell", for: indexPath) as! FavouriteTableViewCell
        
        cell.artistName.text = favourites[indexPath.row].strArtist
        cell.trackName.text = favourites[indexPath.row].strName
        cell.trackDuration.text = Utils.convertSeconds(milliseconds: favourites[indexPath.row].intDuration)
        
        return cell
    }

    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            removeFavourite(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    

    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? DetailsViewController {
            vc.albumId = selectedTrack!.idAlbum
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedTrack = favourites[indexPath.row]
        performSegue(withIdentifier: "showFavouriteDetails", sender: self)
    }
    
    
    // MARK: Core Data
    
    private func removeFavourite(at index: Int) {
        let itemToRemove = favourites[index] as NSManagedObject
        do {
            try CoreDataService.remove(at: index, itemToRemove: itemToRemove)
            favourites.remove(at: index)
        } catch let error {
            print("\(error)")
        }
    }
}
