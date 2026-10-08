//
//  AuthRepository.swift
//  Course Dashboard
//
//  Created by Sameer Jain on 08/10/26.
//

import Foundation

protocol AuthRepositoryProtocol {
    func login(
        email: String,
        password: String
    ) async throws
}

final class AuthRepository: AuthRepositoryProtocol {

    private let apiClient: APIClient

    init(apiClient: APIClient) {
        self.apiClient = apiClient
    }

    func login(
        email: String,
        password: String
    ) async throws {
        try await apiClient.login(
            email: email,
            password: password
        )
    }
}
