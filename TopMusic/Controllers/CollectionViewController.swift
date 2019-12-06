//
//  CollectionViewController.swift
//  TopMusic
//
//  Created by Jon-Martin Heiberg on 16/10/2019.
//  Copyright © 2019 JMHeiberg. All rights reserved.
//

import UIKit


class CollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    private var listView = false
    private var lovedTracks: [Track] = []
    private var selectedTrack: Track?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        WebAPIService.getTracks(albumId: nil, completion: { response in
            if let tracks = response {
                self.lovedTracks = tracks
                self.collectionView.reloadData()
            }
        })

    }
    
    @IBAction func toggleGridView(_ sender: UIBarButtonItem) {
        if (listView) {
            listView = false
            collectionView.reloadData()
        }
    }
    
    @IBAction func toggleListView(_ sender: UIBarButtonItem) {
        if (!listView) {
            listView = true
            collectionView.reloadData()
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var size = CGSize(width: 0, height: 0)
        
        if listView {
            size.height = 50
            size.width = collectionView.frame.width
        } else {
            // Inspired by https://stackoverflow.com/questions/31662155/how-to-change-uicollectionviewcell-size-programmatically-in-swift
            if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
                let itemsPerRow: CGFloat = 2
                let padding: CGFloat = 15
                let totalPadding = padding * (itemsPerRow - 1)
                let individualPadding = totalPadding / itemsPerRow
                let width = collectionView.frame.width / itemsPerRow - individualPadding
                let height = width + 60
                layout.minimumInteritemSpacing = padding
                layout.minimumLineSpacing = padding
                size.height = height
                size.width = width
            }
        }
        return size
    }
    
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? DetailsViewController {
            vc.albumId = selectedTrack!.idAlbum
        }
    }
    
    
    // MARK: UICollectionViewDataSource
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return lovedTracks.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if listView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "trackListCell", for: indexPath) as! ListViewCell
            cell.load(with: lovedTracks[indexPath.row],rank: indexPath.row + 1)
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "trackGridCell", for: indexPath) as! GridViewCell
            cell.load(with: lovedTracks[indexPath.row],rank: indexPath.row + 1)
            return cell
        }
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        selectedTrack = lovedTracks[indexPath.row]
        
        performSegue(withIdentifier: "showAlbum", sender: self)
    }
}

