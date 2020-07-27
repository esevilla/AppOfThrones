//
//  Episode.swift
//  AppOfThrones
//
//  Created by Fernando Torcelly Garcia on 09/02/2020.
//  Copyright © 2020 Fernando Torcelly Garcia. All rights reserved.
//

import Foundation

class Episode: Identifiable, Codable, Equatable, CustomStringConvertible {
    
    var id: Int
    var name: String?
    var date: String?
    var image: String?
    var episode: Int
    var season: Int
    var overview: String
    
    var description: String {
        return "S\(season ?? 0)E\(episode ?? 0) -> \(name ?? "No name")"
    }
    
    init(id: Int, name: String?, date: String?, image: String?, episode: Int, season: Int, overview: String) {
        self.id = id
        self.name = name
        self.date = date
        self.image = image
        self.episode = episode
        self.season = season
        self.overview = overview
    }
    
    static func == (lhs: Episode, rhs: Episode) -> Bool {
        return lhs.id == rhs.id
    }
}
