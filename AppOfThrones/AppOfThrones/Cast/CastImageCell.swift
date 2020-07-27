//
//  CastImageCell.swift
//  AppOfThrones
//
//  Created by Fernando Torcelly Garcia on 02/03/2020.
//  Copyright © 2020 Fernando Torcelly Garcia. All rights reserved.
//

import UIKit

class CastImageCell: UITableViewCell {
    
    @IBOutlet weak var thumb: UIImageView!
    
    func setCast(_ cast: Cast) {
        self.thumb.image = UIImage.init(named: cast.avatar ?? "")
    }
    
}
