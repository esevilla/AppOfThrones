//
//  HouseViewController.swift
//  AppOfThrones
//
//  Created by Fernando Torcelly Garcia on 09/02/2020.
//  Copyright © 2020 Fernando Torcelly Garcia. All rights reserved.
//

import UIKit

class HouseViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var table: UITableView!
    
    var houses: [House] = []
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupData()
        self.setupUI()
    }

    // MARK: - Setup
    
    func setupData() {
        if let pathURL = Bundle.main.url(forResource: "houses", withExtension: "json") {
            do {
                let data = try Data.init(contentsOf: pathURL)
                let decoder = JSONDecoder()
                houses = try decoder.decode([House].self, from: data)
                table.reloadData()
            } catch {
                fatalError("Could not read the JSON")
            }
        } else {
            fatalError("Could not build the path url")
        }
    }
    
    func setupUI() {
        self.title = "Houses"
        
        let nib = UINib.init(nibName: "HouseTableViewCell", bundle: nil)
        table.register(nib, forCellReuseIdentifier: "HouseTableViewCell")
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 126
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let house = houses[indexPath.row]
        
        if let splitViewController = self.splitViewController,
            splitViewController.viewControllers.count > 1 {
            if let navigationController = splitViewController.viewControllers[1] as? UINavigationController,
                let detailViewController = navigationController.visibleViewController as? HouseDetailViewController {
                detailViewController.house = house
            }
        } else {
            let houseDetailVC = HouseDetailViewController.init(house: house)
            self.navigationController?.pushViewController(houseDetailVC, animated: true)
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
    // MARK: - UITableViewDatasource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return houses.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "HouseTableViewCell", for: indexPath) as? HouseTableViewCell {
            cell.setHouse(houses[indexPath.row])
            return cell
        }
        fatalError("Could not create Account cells")
    }
}
