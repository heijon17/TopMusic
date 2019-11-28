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
        var trackToLoad = track
        trackToLoad.strArtist = "\(rank). " + track.strArtist
        loadCell(with: trackToLoad)
    }
    
    public func load(with album: Album) {
        loadCell(with: album)
    }
    
    private func loadCell(with item: Any) {
        if let itemToLoad = item as? Loadable {
            trackName.text = itemToLoad.strName
            trackArtist.text = itemToLoad.strArtist
            if let imageUrl = itemToLoad.strThumb {
                let url = URL(string: imageUrl)
                if let urlUnwrapped = url {
                    trackThumb.load(url: urlUnwrapped)
                    return
                }
            }
            trackThumb.image = UIImage(named: "Mockup_CD")
        }
    }
}

class ListViewCell: UICollectionViewCell {
    @IBOutlet weak var trackName: UILabel!
    @IBOutlet weak var artistName: UILabel!
    
    public func load(with track: Track, rank: Int) {
        trackName.text = "\(rank). " + track.strName
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
