//
//  DataController.swift
//  AppOfThrones
//
//  Created by Fernando Torcelly Garcia on 09/02/2020.
//  Copyright © 2020 Fernando Torcelly Garcia. All rights reserved.
//

import Foundation

protocol FavoriteDelegate {
    func didFavoriteChanged()
}

protocol ReviewDelegate {
    func didReviewChanged()
}

protocol Identifiable {
    var id: Int { get }
}

class DataController {
    
    private var favorite: [Int] = []
    private var rating: [Rating] = []
    
    static let shared = DataController()
    private init(){}
    
    // MARK: - Favorite

    func isFavorite<T: Identifiable>(_ value: T) -> Bool {
        return favorite.contains(value.id)
    }
    
    func addFavorite<T: Identifiable>(_ value: T) {
        if self.isFavorite(value) == false {
            favorite.append(value.id)
        }
    }
    
    func removeFavorite<T: Identifiable>(_ value: T) {
        if let index = favorite.firstIndex(of: value.id) {
            favorite.remove(at: index)
        }
    }
    
    func cleanFavorites() {
        favorite = []
    }
 
    // MARK: - Rating
    
    func rateEpisode(_ episode: Episode, value: Double) {
        if self.ratingForEpisode(episode) == nil {
            let value = Rating.init(id: episode.id, rate: .rated(value: value))
            rating.append(value)
        }
    }
    
    func removeRateEpisode(_ episode: Episode) {
        if let index = self.rating.firstIndex(where: { (rating) -> Bool in
                return episode.id == rating.id
        }) {
            self.rating.remove(at: index)
        }
    }
    
    func ratingForEpisode(_ episode: Episode) -> Rating? {
        let filtered = rating.filter { (rating) -> Bool in
            return rating.id == episode.id
        }
        return filtered.first
    }
    
    func cleanReviews() {
        rating = []
    }
}
