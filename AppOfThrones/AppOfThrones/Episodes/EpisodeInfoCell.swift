//
//  EpisodeInfoCell.swift
//  AppOfThrones
//
//  Created by Fernando Torcelly Garcia on 02/03/2020.
//  Copyright © 2020 Fernando Torcelly Garcia. All rights reserved.
//

import UIKit

class EpisodeInfoCell: UITableViewCell {
    
    @IBOutlet weak var infoValue: UILabel!
    @IBOutlet weak var infoTypeName: UILabel!
    
    func setEpisode(_ episode: Episode, infoType type: EpisodeInfoType) {
        self.infoTypeName.text = type.titleName()
        self.infoValue.text = type.value(episode)
    }
}
