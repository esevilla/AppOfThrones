//
//  CastViewController.swift
//  AppOfThrones
//
//  Created by Fernando Torcelly Garcia on 09/02/2020.
//  Copyright © 2020 Fernando Torcelly Garcia. All rights reserved.
//

import UIKit

class CastViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, CastTableViewCellDelegate, FavoriteDelegate {
    
    @IBOutlet weak var table: UITableView!
    
    var cast: [Cast] = []
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupData()
        self.setupUI()
        self.setupNotifications()
    }
    
    deinit {
        let noteName = Notification.Name(rawValue: "DidFavoritesUpdated")
        NotificationCenter.default.removeObserver(self, name: noteName, object: nil)
    }

    // MARK: - Setup
    
    func setupData() {
        if let pathURL = Bundle.main.url(forResource: "cast", withExtension: "json") {
            do {
                let data = try Data.init(contentsOf: pathURL)
                let decoder = JSONDecoder()
                cast = try decoder.decode([Cast].self, from: data)
                table.reloadData()
            } catch {
                fatalError("Could not read the JSON")
            }
        } else {
            fatalError("Could not build the path url")
        }
    }
    
    func setupUI() {
        self.title = "Cast"
        
        let nib = UINib.init(nibName: "CastTableViewCell", bundle: nil)
        table.register(nib, forCellReuseIdentifier: "CastTableViewCell")
    }
    
    func setupNotifications() {
        let noteName = Notification.Name(rawValue: "DidFavoritesUpdated")
        NotificationCenter.default.addObserver(self, selector: #selector(self.didFavoriteChanged), name: noteName, object: nil)
    }

    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 126
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let castItem = cast[indexPath.row]
        let castDetail = CastDetailViewController.init(withCast: castItem)
        self.navigationController?.pushViewController(castDetail, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // MARK: - UITableViewDatasource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return cast.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "CastTableViewCell", for: indexPath) as? CastTableViewCell {
            cell.setCast(cast[indexPath.row])
            cell.delegate = self
            return cell
        }
        fatalError("Could not create Account cells")
    }
    
    // MARK: - FavoriteDelegate
    
    @objc func didFavoriteChanged() {
        table.reloadData()
    }
}
