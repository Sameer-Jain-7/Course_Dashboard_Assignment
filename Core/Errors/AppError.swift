//
//  AppError.swift
//  Course Dashboard
//
//  Created by Sameer Jain on 08/10/26.
//

import Foundation

enum AppError: LocalizedError {
    case invalidCredentials
    case network
    case decoding
    case persistence
    case unknown

    var errorDescription: String? {
        switch self {
        case .invalidCredentials:
            return "Please enter valid email and password."

        case .network:
            return "Unable to connect. Please try again."

        case .decoding:
            return "Unable to process the server response."

        case .persistence:
            return "Unable to save your data."

        case .unknown:
            return "Something went wrong."
        }
    }
}
