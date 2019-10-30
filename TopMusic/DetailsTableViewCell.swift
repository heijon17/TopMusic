//
//  DetailsTableViewCell.swift
//  TopMusic
//
//  Created by Jon-Martin Heiberg on 30/10/2019.
//  Copyright © 2019 JMHeiberg. All rights reserved.
//

import UIKit

class DetailsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var trackName: UILabel!
    @IBOutlet weak var trackDuration: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
