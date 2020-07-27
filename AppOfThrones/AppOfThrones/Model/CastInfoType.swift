//
//  CastInfoType.swift
//  AppOfThrones
//
//  Created by Fernando Torcelly Garcia on 02/03/2020.
//  Copyright © 2020 Fernando Torcelly Garcia. All rights reserved.
//

import Foundation

enum CastInfoType: Int {
    case avatar = 0
    case fullname
    case role
    case episodes
    case birth
    case placeBirth
    
    func titleName() -> String {
        switch self {
        case .fullname:
            return "Name"
        case .role:
            return "Role"
        case .episodes:
            return "Number of Episodes"
        case .birth:
            return "Birthdate"
        case .placeBirth:
            return "Born in"
        default:
            return ""
        }
    }
    
    func value(_ cast: Cast) -> String? {
        switch self {
        case .fullname:
            return cast.fullname
        case .role:
            return cast.role
        case .episodes:
            return "\(cast.episodes ?? 0)"
        case .birth:
            return cast.birth
        case .placeBirth:
            return cast.placeBirth
        case .avatar:
            return cast.avatar
        }
    }
}
