//
//  ValidatorError.swift
//  AppOfThrones
//
//  Created by Fernando Torcelly Garcia on 10/02/2020.
//  Copyright © 2020 Fernando Torcelly Garcia. All rights reserved.
//

import Foundation

enum ValidatorError: Error {
    case tooShort
    case tooLong
    case invalidCharacterFound(Character)
}

extension ValidatorError: LocalizedError {
    
    var errorDescription: String? {
        switch self {
        case .tooShort:
            return "Tu nombre de usuario necesita al menos 4 caracteres"
        case .tooLong:
            return "Tu nombre de usuario debe ser menor de 15 caracteres"
        case .invalidCharacterFound(let ch):
            return "Tu nombre de usuario no puede tener el caracter: \(ch)"
        }
    }
    
}
