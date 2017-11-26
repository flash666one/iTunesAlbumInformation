//
//  ResultTableViewCell.swift
//  iTunesAlbumInformation
//
//  Created by Артём Горюнов on 23.11.2017.
//  Copyright © 2017 Артём Горюнов. All rights reserved.
//

import UIKit

class ArtistResultTableViewCell: UITableViewCell {
    
    @IBOutlet weak var ArtistResult: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
