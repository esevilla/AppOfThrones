//
//  FavoritesViewController.swift
//  AppOfThrones
//
//  Created by Fernando Torcelly Garcia on 02/03/2020.
//  Copyright © 2020 Fernando Torcelly Garcia. All rights reserved.
//

import UIKit

class FavoritesViewController: EpisodeViewController {
    
    var favoriteEpisodes: [Episode] {
        return episodes.filter({ DataController.shared.isFavorite( $0 ) })
    }
    
    // MARK: - Setup
    
    override func setupUI() {
        super.setupUI()
        self.title = "Favorites"
        self.seasonSegmented?.isHidden = true
        self.topConstraint.constant = -24
    }
    
    override func setupData(season: Int) {
        episodes = []
        
        for season in 1...8 {
            if let pathURL = Bundle.main.url(forResource: "season_\(season)", withExtension: "json") {
                do {
                    let data = try Data.init(contentsOf: pathURL)
                    let decoder = JSONDecoder()
                    let newEpisodes: [Episode] = try decoder.decode([Episode].self, from: data)
                    episodes.append(contentsOf: newEpisodes)
                } catch {
                    fatalError("Could not read the JSON")
                }
            } else {
                fatalError("Could not build the path url")
            }
        }
        table.reloadData()
    }
    
    // MARK: - UITableViewDelegate

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let episode = favoriteEpisodes[indexPath.row]
        let episodeDetail = EpisodeDetailViewController.init(withEpisode: episode)
        self.navigationController?.pushViewController(episodeDetail, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // MARK: - UITableViewDatasource
    
    override func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return favoriteEpisodes.count
    }
    
    override func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let episode = favoriteEpisodes[indexPath.row]
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "EpisodeTableViewCell", for: indexPath) as? EpisodeTableViewCell {
            cell.setEpisode(episode)
            cell.delegate = self
            cell.rateBlock = {
                let rateViewController = RateViewController.init(withEpisode: episode)
                let navigationController = UINavigationController.init(rootViewController: rateViewController)
                navigationController.modalPresentationStyle = UIDevice.current.userInterfaceIdiom == .pad ? .formSheet : .fullScreen
                self.present(navigationController, animated: true, completion: nil)
            }
            return cell
        }
        fatalError("Could not create Account cells")
    }

}
