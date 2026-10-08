//
//  LoginViewModel.swift
//  Course Dashboard
//
//  Created by Sameer Jain on 08/10/26.
//

import Foundation
import Observation

@MainActor
@Observable
final class LoginViewModel {

    var email = ""
    var password = ""

    var isLoading = false
    var errorMessage: String?

    private let repository:
        AuthRepositoryProtocol

    init(
        repository: AuthRepositoryProtocol
    ) {
        self.repository = repository
    }

    var isValid: Bool {
        email.contains("@") &&
        !password.isEmpty
    }

    func login() async -> Bool {

        guard isValid else {
            errorMessage =
                "Enter a valid email and password."
            return false
        }

        isLoading = true
        errorMessage = nil

        defer {
            isLoading = false
        }

        do {
            try await repository.login(
                email: email,
                password: password
            )

            return true

        } catch {
            errorMessage =
                error.localizedDescription

            return false
        }
    }
}
