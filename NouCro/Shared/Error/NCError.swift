//
//  NCError.swift
//  NouCro
//
//  Created by AliReza on 2024-10-25.
//

import Foundation

enum NCError: Error {
    var description: String {
        var errorMessage: String = ""
        switch self {
        case .dataBaseError(message: let message):
            errorMessage.append("Database Error: \(message)")
        case .gameLogicError(message: let message):
            errorMessage.append("Game logic Error: \(message)")
        }
        return errorMessage
    }
    case dataBaseError(message: String)
    case gameLogicError(message: String)
}
