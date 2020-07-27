//
//  Rating.swift
//  AppOfThrones
//
//  Created by Fernando Torcelly Garcia on 09/02/2020.
//  Copyright © 2020 Fernando Torcelly Garcia. All rights reserved.
//

import Foundation

enum Rate {
    case unrated
    case rated(value: Double)
}

struct Rating: Equatable, CustomStringConvertible {
    var id: Int
    var rate: Rate
    
    var description: String {
        var str = ""
        switch rate {
        case .unrated:
            str = "Unrated"
        case .rated(let value):
            str = "Rated: \(value)"
        }
        return "\(id) -> \(str)"
    }
    
    static func == (lhs: Rating, rhs: Rating) -> Bool {
        return lhs.id == rhs.id
    }
}
