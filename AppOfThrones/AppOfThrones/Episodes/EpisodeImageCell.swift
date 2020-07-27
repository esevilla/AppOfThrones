//
//  EpisodeImageCell.swift
//  AppOfThrones
//
//  Created by Fernando Torcelly Garcia on 02/03/2020.
//  Copyright © 2020 Fernando Torcelly Garcia. All rights reserved.
//

import UIKit

class EpisodeImageCell: UITableViewCell {
    
    @IBOutlet weak var thumbnail: UIImageView!
    
    func setEpisode(_ episode: Episode) {
        self.thumbnail.image = UIImage.init(named: episode.image ?? "")
    }
}
