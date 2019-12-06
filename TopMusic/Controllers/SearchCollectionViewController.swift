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
        WebAPIService.getAlbumSearch(albumName: searchString, completion: { response in
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
}

/* https://stackoverflow.com/questions/38300445/how-to-search-when-search-button-clicked-in-keyboard */

extension SearchCollectionViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let albumName = searchBar.text {
            updateWithSearchResults(searchString: albumName)
        }
    }
}
