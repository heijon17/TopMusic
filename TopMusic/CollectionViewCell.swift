//
//  CollectionViewCell.swift
//  TopMusic
//
//  Created by Jon-Martin Heiberg on 16/10/2019.
//  Copyright © 2019 JMHeiberg. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var trackThumb: UIImageView!
    @IBOutlet weak var trackArtist: UILabel!
    @IBOutlet weak var TrackName: UILabel!
    
    public func load(with track: Track) {
        if let imageUrl = track.strTrackThumb {
            let url = URL(string: imageUrl)
            trackThumb.load(url: url!)
        }
        
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
