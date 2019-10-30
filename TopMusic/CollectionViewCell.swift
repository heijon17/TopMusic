//
//  CollectionViewCell.swift
//  TopMusic
//
//  Created by Jon-Martin Heiberg on 16/10/2019.
//  Copyright © 2019 JMHeiberg. All rights reserved.
//

import UIKit

class GridViewCell: UICollectionViewCell {
    @IBOutlet weak var trackThumb: UIImageView!
    @IBOutlet weak var trackArtist: UILabel!
    @IBOutlet weak var trackName: UILabel!
    
    public func load(with track: Track, rank: Int) {
        trackArtist.text = "\(rank). " + track.strArtist
        trackName.text = track.strTrack
        
        if track.strTrackThumb == nil {
            trackThumb.image = UIImage(named: "Mockup_CD")
            return
        }
        
        if let imageUrl = track.strTrackThumb {
            let url = URL(string: imageUrl)
            trackThumb.load(url: url!)
        }
    }
}

class ListViewCell: UICollectionViewCell {
    @IBOutlet weak var trackName: UILabel!
    @IBOutlet weak var artistName: UILabel!
    
    public func load(with track: Track, rank: Int) {
        trackName.text = "\(rank). " + track.strTrack
        artistName.text = track.strArtist
    }
}



// https://www.hackingwithswift.com/example-code/uikit/how-to-load-a-remote-image-url-into-uiimageview

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
