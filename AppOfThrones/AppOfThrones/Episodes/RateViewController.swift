//
//  RateViewController.swift
//  AppOfThrones
//
//  Created by Fernando Torcelly Garcia on 09/02/2020.
//  Copyright © 2020 Fernando Torcelly Garcia. All rights reserved.
//

import UIKit

class RateViewController: UIViewController {
    
    private var episode: Episode?
    
    @IBOutlet weak var confirmButton: UIButton!
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var rateSlider: UISlider!
    @IBOutlet weak var thumbnail: UIImageView!
    @IBOutlet weak var star01: UIImageView!
    @IBOutlet weak var star02: UIImageView!
    @IBOutlet weak var star03: UIImageView!
    @IBOutlet weak var star04: UIImageView!
    @IBOutlet weak var star05: UIImageView!
    
    convenience init(withEpisode episode: Episode) {
        self.init(nibName: "RateViewController", bundle: nil)
        self.episode = episode
        self.title = episode.name
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        self.setupNavigationBar()
    }
    
    func setupUI() {
        confirmButton.layer.cornerRadius = 4.0
        thumbnail.layer.cornerRadius = 4.0
        thumbnail.layer.borderColor  = UIColor.white.withAlphaComponent(0.2).cgColor
        thumbnail.layer.borderWidth  = 1.0
        
        if let episodeImage = episode?.image {
            thumbnail.image = UIImage.init(named: episodeImage)
        }
    }
    
    func setupNavigationBar() {
        let backButton = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: 30, height: 30))
        let backImage  = UIImage.init(systemName: "xmark")
        backButton.setImage(backImage, for: UIControl.State.normal)
        backButton.addTarget(self, action: #selector(self.close), for: .touchUpInside)
        let barBackItem = UIBarButtonItem.init(customView: backButton)
        self.navigationItem.leftBarButtonItem = barBackItem
    }
    
    // MARK: - IBActions
    
    @IBAction func confirm(_ sender: Any) {
        let rate = Double(Int(rateSlider.value * 5)/10)
        if let episode = episode {
            DataController.shared.rateEpisode(episode, value: rate)
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func rateChanged(_ sender: UISlider) {
        let rate = Double(Int(sender.value * 5)/10)
        self.setRating(rate)
    }
    
    @IBAction func close(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Rating
    
    func setRating(_ rating: Double) {
        rateLabel.text = String(rating)
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
}
