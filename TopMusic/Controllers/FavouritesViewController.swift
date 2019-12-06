//
//  FavouritesViewController.swift
//  TopMusic
//
//  Created by Jon-Martin Heiberg on 04/12/2019.
//  Copyright © 2019 JMHeiberg. All rights reserved.
//

import UIKit
import CoreData

class FavouritesViewController: UIViewController {

    @IBOutlet weak var favouriteTableView: UITableView!
    @IBOutlet weak var recommendedCollectionView: UICollectionView!
    
    private var favourites = [FavouriteTrack]()
    private var selectedTrack: FavouriteTrack?
    private var recommendedArtists = [RecArtist]()
    private var recCellSize = CGSize()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = editButtonItem
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        editing ? favouriteTableView.setEditing(true, animated: animated) : favouriteTableView.setEditing(false, animated: animated)
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        CoreDataService.favourites(completion: { results in
            if let tracks = results {
                self.favourites = tracks
                self.favouriteTableView.reloadData()
            }
        })
        loadRecommendedArtists()
    }
    
    private func loadRecommendedArtists() {
        WebAPIService.getRecommendedArtists(favourites: favourites, completion: { results in
            if let artists = results {
                self.recommendedArtists = artists
                self.recommendedCollectionView.reloadData()
            }
            
        })
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? DetailsViewController {
            vc.albumId = selectedTrack!.idAlbum
        }
    }
}

// MARK: - Table View

extension FavouritesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favourites.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavouriteCell", for: indexPath) as! FavouriteTableViewCell
        
        cell.artistName.text = favourites[indexPath.row].strArtist
        cell.trackName.text = favourites[indexPath.row].strName
        cell.trackDuration.text = Utils.convertSeconds(milliseconds: favourites[indexPath.row].intDuration)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let alert = UIAlertController(title: "Delete from favourites?", message: "Do you want to remove '\(favourites[indexPath.row].strName)' from favourites?", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            alert.addAction(UIAlertAction(title: "Remove", style: .default, handler: {_ in
                self.removeFavourite(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            }))
            self.present(alert, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let trackToMove = favourites[sourceIndexPath.row]
        favourites.remove(at: sourceIndexPath.row)
        favourites.insert(trackToMove, at: destinationIndexPath.row)
        
        do {
            try CoreDataService.updateOrder(tracks: favourites)
        } catch let error {
            print("\(error)")
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedTrack = favourites[indexPath.row]
        performSegue(withIdentifier: "showFavouriteDetails", sender: self)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    // MARK: Core Data
    
    private func removeFavourite(at index: Int) {
        let itemToRemove = favourites[index] as NSManagedObject
        do {
            try CoreDataService.remove(itemToRemove: itemToRemove)
            favourites.remove(at: index)
            loadRecommendedArtists()
        } catch let error {
            print("\(error)")
        }
    }

}


// MARK: - Collection View

extension FavouritesViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recommendedArtists.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecCell", for: indexPath) as! RecArtistsCollectionViewCell
        
        cell.artistName.text = recommendedArtists[indexPath.row].name
        cell.artistName.frame = CGRect(x: 0, y: 0, width: recCellSize.width, height: recCellSize.height)
        cell.artistName.lineBreakMode = .byWordWrapping
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
   
        // https://stackoverflow.com/questions/38025112/how-do-i-set-collection-views-cell-size-via-the-auto-layout

        let cellsAcross: CGFloat = 3
        let spaceBetweenCells: CGFloat = 1
        let dim = (collectionView.bounds.width - (cellsAcross - 1) * spaceBetweenCells) / cellsAcross
        recCellSize = CGSize(width: dim, height: dim / 2)
        return recCellSize
        
    }
}
