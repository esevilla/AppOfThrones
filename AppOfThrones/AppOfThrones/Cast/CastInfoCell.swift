//
//  CastInfoCell.swift
//  AppOfThrones
//
//  Created by Fernando Torcelly Garcia on 02/03/2020.
//  Copyright © 2020 Fernando Torcelly Garcia. All rights reserved.
//

import UIKit

class CastInfoCell: UITableViewCell {

    @IBOutlet weak var infoValue: UILabel!
    @IBOutlet weak var infoTypeName: UILabel!
    
    func setCast(_ cast: Cast, infoType type: CastInfoType) {
        self.infoTypeName.text = type.titleName()
        self.infoValue.text = type.value(cast)
    }
    
}
