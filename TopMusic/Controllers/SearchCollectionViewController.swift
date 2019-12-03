//
//  SearchCollectionViewController.swift
//  TopMusic
//
//  Created by Jon-Martin Heiberg on 27/11/2019.
//  Copyright © 2019 JMHeiberg. All rights reserved.
//

import UIKit

private let reuseIdentifier = "trackGridCell"

class SearchCollectionViewController: CollectionViewController {

    private var searchResults: [Album] = []
    private var selectedAlbum: Album?
    
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController

    }

    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? DetailsViewController {
            vc.albumId = selectedAlbum!.idAlbum
        }
    }
    

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchResults.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
            as! GridViewCell
    
        cell.load(with: searchResults[indexPath.row])
        return cell
    }
    
    func updateWithSearchResults(searchString: String) {
        searchController.isActive = false
        WebAPI.getAlbumSearch(albumName: searchString, completion: { response in
            if let album = response {
                self.searchResults = album
                self.collectionView.reloadData()
                if album.isEmpty {
                    self.showAlert(message: "No results for \(searchString)")
                }
            }
        })
    }
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        present(alert, animated: true, completion: nil)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
            self.dismiss(animated: true, completion: nil)
        })
    }

    // MARK: UICollectionViewDelegate
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedAlbum = searchResults[indexPath.row]
        performSegue(withIdentifier: "showAlbum", sender: self)
    }

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}

/* https://stackoverflow.com/questions/38300445/how-to-search-when-search-button-clicked-in-keyboard */

extension SearchCollectionViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let albumName = searchBar.text {
            updateWithSearchResults(searchString: albumName)
        }
    }
}
