//
//  SettingsViewController.swift
//  AppOfThrones
//
//  Created by Fernando Torcelly Garcia on 09/02/2020.
//  Copyright © 2020 Fernando Torcelly Garcia. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var userField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }

    // MARK: - Setup
    
    func setupUI() {
        self.title = "Settings"
    }
    
    func validate(username: String) throws {
        guard username.count > 3 else {
            throw ValidatorError.tooShort
        }
        guard username.count < 15 else {
            throw ValidatorError.tooLong
        }
        for character in username {
            guard character.isLetter else {
                throw ValidatorError.invalidCharacterFound(character)
            }
        }
    }
    
    @IBAction func hideKeyboard(_ sender: Any) {
        self.view.endEditing(true)
    }
    
    @IBAction func validate(_ sender: Any) {
        if let username = userField.text {
            do {
                try validate(username: username)
            } catch {
                errorLabel.text = error.localizedDescription
            }
        }
    }
    
    // MARK: - Setup
    
    @IBAction func cleanFavoritesAction(_ sender: Any) {
        DataController.shared.cleanFavorites()
        
        // Actualizar todas las tablas donde aparezca episodios
        // o actores con el icono favorito
        let noteName = Notification.Name(rawValue: "DidFavoritesUpdated")
        NotificationCenter.default.post(name: noteName, object: nil)
    }
    
    @IBAction func cleanReviewsAction(_ sender: Any) {
        DataController.shared.cleanReviews()
        
        // Actualizar todas las tablas donde aparezca episodios
        // o actores con el icono favorito
        let noteName = Notification.Name(rawValue: "DidReviewsUpdated")
        NotificationCenter.default.post(name: noteName, object: nil)
    }
}
