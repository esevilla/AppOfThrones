//
//  EpisodeDetailViewController.swift
//  AppOfThrones
//
//  Created by Fernando Torcelly Garcia on 10/02/2020.
//  Copyright © 2020 Fernando Torcelly Garcia. All rights reserved.
//

import UIKit

class EpisodeDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var table: UITableView!
    private var episode: Episode?
    private let rows: [EpisodeInfoType] = [.name, .season, .episode, .date, .overview]
    
    convenience init(withEpisode episode: Episode) {
        self.init(nibName: "EpisodeDetailViewController", bundle: nil)
        self.episode = episode
        self.title = episode.name
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTable()
    }
    
    // MARK: - Setup
    
    private func setupTable() {
        let nibImage = UINib.init(nibName: "EpisodeImageCell", bundle: nil)
        table.register(nibImage, forCellReuseIdentifier: "EpisodeImageCell")
        let nibInfo = UINib.init(nibName: "EpisodeInfoCell", bundle: nil)
        table.register(nibInfo, forCellReuseIdentifier: "EpisodeInfoCell")
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // Con (118/207.0) mantiene el aspect ratio de la imagen de un episodio
        // en función del ancho de la pantalla (UIScreen.main.bounds.width)
        if indexPath.row == 0 {
            return UIScreen.main.bounds.width * (118/207.0)
        } else if indexPath.row == rows.count {
            return 184
        } else {
            return 92
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // MARK: - UITableViewDatasource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return rows.count+1
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let episodeUnwrapped = self.episode else {
            fatalError("The episode is nil")
        }
        
        if indexPath.row == 0 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "EpisodeImageCell", for: indexPath) as? EpisodeImageCell {
                cell.setEpisode(episodeUnwrapped)
                return cell
            }
        } else {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "EpisodeInfoCell", for: indexPath) as? EpisodeInfoCell {
                let row = indexPath.row - 1
                cell.setEpisode(episodeUnwrapped, infoType: rows[row])
                return cell
            }
        }
        
        fatalError("Could not create Account cells")
    }
    
}
