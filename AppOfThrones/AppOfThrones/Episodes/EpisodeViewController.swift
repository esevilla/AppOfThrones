//
//  EpisodeViewController.swift
//  AppOfThrones
//
//  Created by Fernando Torcelly Garcia on 09/02/2020.
//  Copyright © 2020 Fernando Torcelly Garcia. All rights reserved.
//

import UIKit

class EpisodeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, EpisodeTableViewCellDelegate, FavoriteDelegate, ReviewDelegate {
    
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    @IBOutlet weak var seasonSegmented: UISegmentedControl!
    @IBOutlet weak var table: UITableView!
    
    var episodes: [Episode] = [Episode.init(id: 1, name: "Winter Is Coming", date: "April 17, 2011", image: "episodeTest", episode: 1, season: 1, overview: "Jon Arryn, the Hand of the King, is dead. King Robert Baratheon plans to ask his oldest friend, Eddard Stark, to take Jon's place. Across the sea, Viserys Targaryen plans to wed his sister to a nomadic warlord in exchange for an army.")]
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        self.setupData(season: 1)
        self.setupNotifications()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        table.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("viewWillAppear")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("viewWillDisappear")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("viewDidDisappear")
    }
    
    deinit {
        let noteName = Notification.Name(rawValue: "DidFavoritesUpdated")
        NotificationCenter.default.removeObserver(self, name: noteName, object: nil)
    }

    // MARK: - Setup
    
    func setupUI() {
        self.title = "Seasons"
        
        seasonSegmented.selectedSegmentTintColor = UIColor.black.withAlphaComponent(0.75)
        seasonSegmented.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        seasonSegmented.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(0.75)], for: .normal)
        
        let nib = UINib.init(nibName: "EpisodeTableViewCell", bundle: nil)
        table.register(nib, forCellReuseIdentifier: "EpisodeTableViewCell")
    }
    
    func setupData(season: Int) {
        if let pathURL = Bundle.main.url(forResource: "season_\(season)", withExtension: "json") {
            do {
                let data = try Data.init(contentsOf: pathURL)
                let decoder = JSONDecoder()
                episodes = try decoder.decode([Episode].self, from: data)
                table.reloadData()
            } catch {
                fatalError("Could not read the JSON")
            }
        } else {
            fatalError("Could not build the path url")
        }
    }
    
    func setupNotifications() {
        let noteName = Notification.Name(rawValue: "DidFavoritesUpdated")
        NotificationCenter.default.addObserver(self, selector: #selector(self.didFavoriteChanged), name: noteName, object: nil)
    }
    
    // MARK: - IBActions

    @IBAction func segmentedChanged(_ sender: UISegmentedControl) {
        print("Temporada seleccionada \(sender.selectedSegmentIndex+1)")
        let season = sender.selectedSegmentIndex+1
        self.setupData(season: season)
        self.table.reloadData()
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 123
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let episode = episodes[indexPath.row]
        let episodeDetail = EpisodeDetailViewController.init(withEpisode: episode)
        self.navigationController?.pushViewController(episodeDetail, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // MARK: - UITableViewDatasource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return episodes.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let episode = episodes[indexPath.row]
        
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
    
    // MARK: - FavoriteDelegate
    
    @objc func didFavoriteChanged() {
        table.reloadData()
    }
    
    // MARK: - ReviewDelegate
    
    func didReviewChanged() {
        table.reloadData()
    }
}
