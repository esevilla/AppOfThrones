//
//  HouseDetailViewController.swift
//  AppOfThrones
//
//  Created by Fernando Torcelly Garcia on 09/02/2020.
//  Copyright © 2020 Fernando Torcelly Garcia. All rights reserved.
//

import UIKit

class HouseDetailViewController: UIViewController {
    
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var sigil: UILabel!
    @IBOutlet weak var words: UILabel!
    
    var house: House? {
        didSet {
            self.title = self.house?.name
            avatar.image = UIImage.init(named: self.house?.name ?? "")
            sigil.text = self.house?.seat
            words.text = self.house?.words
        }
    }
    
    convenience init(house: House) {
        self.init(nibName: "HouseDetailViewController", bundle: nil)
        self.title = house.name
        self.house = house
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        avatar.image = UIImage.init(named: self.house?.name ?? "")
        
    }
}
