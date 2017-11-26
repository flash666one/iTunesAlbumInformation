//
//  SongTableViewCell.swift
//  iTunesAlbumInformation
//
//  Created by Артём Горюнов on 23.11.2017.
//  Copyright © 2017 Артём Горюнов. All rights reserved.
//

import UIKit

class SongTableViewCell: UITableViewCell {
    
    //клас ячейки с песней
    
    @IBOutlet weak var songNumber: UILabel!
    
    @IBOutlet weak var songInfo: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
