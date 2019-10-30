//
//  DetailsVC.swift
//  TopMusic
//
//  Created by Jon-Martin Heiberg on 29/10/2019.
//  Copyright © 2019 JMHeiberg. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   

    @IBOutlet weak var trackTable: UITableView!
    @IBOutlet weak var albumImage: UIImageView!
    @IBOutlet weak var albumTitle: UILabel!
    @IBOutlet weak var artistName: UILabel!
    

    
    var tracks: [Track] = []
    var albumInfo: Track?
    let cellIdentifier = "albumTrackCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.albumTitle.text = albumInfo?.strAlbum
        self.artistName.text = albumInfo?.strArtist
        

        WebAPI.getTracks(albumId: albumInfo?.idAlbum, completion: { response in
            if let tracks = response {
                self.tracks = tracks
                self.trackTable.reloadData()
            }
        })
        
        if let strUrl = albumInfo?.strTrackThumb {
            let url = URL(string: strUrl)
            albumImage.load(url: url!)
            
        }
        albumImage.frame.size = CGSize(width: self.view.frame.width, height: self.view.frame.width)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tracks.count
    }
    
    
       
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        
        cell.textLabel?.text = "\(indexPath.row + 1). \(tracks[indexPath.row].strTrack)"
        
        return cell
    }

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
