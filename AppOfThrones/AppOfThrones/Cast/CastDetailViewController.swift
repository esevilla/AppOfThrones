//
//  CastDetailViewController.swift
//  AppOfThrones
//
//  Created by Fernando Torcelly Garcia on 02/03/2020.
//  Copyright © 2020 Fernando Torcelly Garcia. All rights reserved.
//

import UIKit

class CastDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var table: UITableView!
    private var cast: Cast?
    private let rows: [CastInfoType] = [.fullname, .role, .episodes, .birth, .placeBirth]
    
    convenience init(withCast cast: Cast) {
        self.init(nibName: "CastDetailViewController", bundle: nil)
        self.cast = cast
        self.title = cast.fullname
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTable()
    }
    
    // MARK: - Setup
    
    private func setupTable() {
        let nibImage = UINib.init(nibName: "CastImageCell", bundle: nil)
        table.register(nibImage, forCellReuseIdentifier: "CastImageCell")
        let nibInfo = UINib.init(nibName: "CastInfoCell", bundle: nil)
        table.register(nibInfo, forCellReuseIdentifier: "CastInfoCell")
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // Altura igual al ancho de la pantalla (UIScreen.main.bounds.width)
        // para conseguir imagen cuadrada
        if indexPath.row == 0 {
            return UIScreen.main.bounds.width
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
        
        guard let castUnwrapped = self.cast else {
            fatalError("The episode is nil")
        }
        
        if indexPath.row == 0 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "CastImageCell", for: indexPath) as? CastImageCell {
                cell.setCast(castUnwrapped)
                return cell
            }
        } else {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "CastInfoCell", for: indexPath) as? CastInfoCell {
                let row = indexPath.row - 1
                cell.setCast(castUnwrapped, infoType: rows[row])
                return cell
            }
        }
        
        fatalError("Could not create Account cells")
    }

}
