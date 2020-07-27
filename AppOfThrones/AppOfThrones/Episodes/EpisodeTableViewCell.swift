//
//  EpisodeTableViewCell.swift
//  AppOfThrones
//
//  Created by Fernando Torcelly Garcia on 08/02/2020.
//  Copyright © 2020 Fernando Torcelly Garcia. All rights reserved.
//

import UIKit

protocol EpisodeTableViewCellDelegate: class {
    func didFavoriteChanged()
}

class EpisodeTableViewCell: UITableViewCell {
    
    private weak var episode: Episode?
    weak var delegate: EpisodeTableViewCellDelegate?
    
    var rateBlock: (()->Void)?
    
    @IBOutlet weak var thumb: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var star01: UIImageView!
    @IBOutlet weak var star02: UIImageView!
    @IBOutlet weak var star03: UIImageView!
    @IBOutlet weak var star04: UIImageView!
    @IBOutlet weak var star05: UIImageView!
    @IBOutlet weak var rateButton: UIButton!
    @IBOutlet weak var heart: UIImageView!
    
    override func awakeFromNib() {
        thumb.layer.cornerRadius = 2.0
        thumb.layer.borderColor  = UIColor.white.withAlphaComponent(0.2).cgColor
        thumb.layer.borderWidth  = 1.0
        rateButton.layer.cornerRadius = 15
        
        self.modeRate()
    }
    
    // MARK: - Rating
    
    func modeRate() {
        rateButton.isHidden = false
        ratingLabel.isHidden = true
        star01.isHidden = true
        star02.isHidden = true
        star03.isHidden = true
        star04.isHidden = true
        star05.isHidden = true
    }
    
    func setRating(_ rating: Double) {
        rateButton.isHidden = true
        ratingLabel.isHidden = false
        star01.isHidden = false
        star02.isHidden = false
        star03.isHidden = false
        star04.isHidden = false
        star05.isHidden = false
        
        self.setStarImage(star01, rating: rating, minValue: 0)
        self.setStarImage(star02, rating: rating, minValue: 2)
        self.setStarImage(star03, rating: rating, minValue: 4)
        self.setStarImage(star04, rating: rating, minValue: 6)
        self.setStarImage(star05, rating: rating, minValue: 8)
    }
    
    private func setStarImage(_ imageView: UIImageView, rating: Double, minValue: Double) {
        if rating >= minValue + 1.0 && rating < minValue + 2.0 {
            imageView.image = UIImage.init(systemName: "star.lefthalf.fill")
        } else if rating >= minValue + 2.0 {
            imageView.image = UIImage.init(systemName: "star.fill")
        } else {
            imageView.image = UIImage.init(systemName: "star")
        }
    }
    
    // MARK: - Setter
    
    func setEpisode(_ episode: Episode) {
        self.episode = episode
        thumb.image = episode.image == nil ? nil : UIImage.init(named: episode.image!)
        title.text  = episode.name
        date.text   = episode.date
        
        if let ratingValue = DataController.shared.ratingForEpisode(episode) {
            switch ratingValue.rate {
            case .rated(let value):
                ratingLabel.text = String(value)
                self.setRating(value)
            case .unrated:
                self.modeRate()
            }
        } else {
            self.modeRate()
        }
        
        let systemName = DataController.shared.isFavorite(episode) ? "heart.fill" : "heart"
        heart.image = UIImage.init(systemName: systemName)
    }
    
    // MARK: - IBAction
    
    @IBAction func rate(_ sender: Any) {
        self.rateBlock?()
    }
    
    @IBAction func favoriteAction() {
        if let episode = episode {
            if DataController.shared.isFavorite(episode) {
                DataController.shared.removeFavorite(episode)
            } else {
                DataController.shared.addFavorite(episode)
            }
            delegate?.didFavoriteChanged()
        }
    }
}
