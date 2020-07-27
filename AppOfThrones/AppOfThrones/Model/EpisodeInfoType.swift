//
//  EpisodeInfoType.swift
//  AppOfThrones
//
//  Created by Fernando Torcelly Garcia on 02/03/2020.
//  Copyright © 2020 Fernando Torcelly Garcia. All rights reserved.
//

import Foundation

enum EpisodeInfoType: Int {
    case image = 0
    case name
    case date
    case season
    case episode
    case overview
    
    func titleName() -> String {
        switch self {
        case .name:
            return "Name"
        case .date:
            return "Date"
        case .season:
            return "Season"
        case .episode:
            return "Episode"
        case .overview:
            return "Overview"
        default:
            return ""
        }
    }
    
    func value(_ episode: Episode) -> String? {
        switch self {
        case .name:
            return episode.name
        case .date:
            return episode.date
        case .image:
            return episode.image
        case .episode:
            return "\(episode.episode)"
        case .season:
            return "\(episode.season)"
        case .overview:
            return "\(episode.overview)"
        }
    }
}
