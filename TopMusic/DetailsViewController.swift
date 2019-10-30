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
    @IBOutlet weak var albumYear: UILabel!
    

    
    var tracks: [Track] = []
    var albumId: String = ""
    let cellIdentifier = "albumTrackCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        WebAPI.getAlbum(albumId: albumId, completion: { response in
            if let album = response {
                self.updateView(with: album[0])
            }
        })

        WebAPI.getTracks(albumId: albumId, completion: { response in
            if let tracks = response {
                self.tracks = tracks
                self.trackTable.reloadData()
            }
        })
        
 
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tracks.count
    }
    
    
       
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! DetailsTableViewCell
        
        cell.trackName?.text = "\(indexPath.row + 1). \(tracks[indexPath.row].strTrack)"
        cell.trackDuration.text = Utils.convertSeconds(milliseconds: tracks[indexPath.row].intDuration)
        
        return cell
    }
    
    func updateView(with album: Album) {
        self.albumTitle.text = album.strAlbum
        self.artistName.text = album.strArtist
        self.albumYear.text = album.intYearReleased
        if let strUrl = album.strAlbumThumb {
            let url = URL(string: strUrl)
            albumImage.load(url: url!)
        } else {
            albumImage.image = UIImage(named: "Mockup_CD")
        }
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
