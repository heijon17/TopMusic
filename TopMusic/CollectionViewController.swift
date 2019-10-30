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
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Do any additional setup after loading the view.
        WebAPI.getTracks(albumId: nil, completion: { response in
            if let tracks = response {
                self.lovedTracks = tracks
                self.collectionView.reloadData()
            }
        })

    }
    
    @IBAction func toggleGridView(_ sender: UIBarButtonItem) {
        listView = false
        collectionView.reloadData()
    }
    
    @IBAction func toggleListView(_ sender: UIBarButtonItem) {
        listView = true
        collectionView.reloadData()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var size = CGSize(width: 0, height: 0)
        
        if listView {
            size.height = 50
            size.width = collectionView.frame.width
        } else {
            
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
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? DetailsViewController {
            vc.albumId = selectedTrack!.idAlbum
        }
        
    }
    
    
    // MARK: UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
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
    
    
    
    
    // MARK: UICollectionViewDelegate
    
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

