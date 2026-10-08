//
//  LoginView.swift
//  Course Dashboard
//
//  Created by Sameer Jain on 08/10/26.
//

import SwiftUI

struct LoginView: View {

    @State private var viewModel:
        LoginViewModel

    let onLoginSuccess: () -> Void

    init(
        viewModel: LoginViewModel,
        onLoginSuccess: @escaping () -> Void
    ) {
        _viewModel = State(
            initialValue: viewModel
        )

        self.onLoginSuccess = onLoginSuccess
    }

    var body: some View {

        ZStack {

            LinearGradient(
                colors: [
                    Color.accentColor.opacity(0.5),
                    Color.indigo.opacity(0.28),
                    Color(.systemBackground)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            ScrollView {

                VStack(spacing: 28) {

                    Spacer(minLength: 50)

                    logo

                    header

                    loginForm

                    Spacer()
                }
                .padding(.horizontal, 24)
            }
        }
        .alert(
            "Login Failed",
            isPresented: Binding(
                get: {
                    viewModel.errorMessage != nil
                },
                set: { value in
                    if !value {
                        viewModel.errorMessage = nil
                    }
                }
            )
        ) {
            Button("OK") {
                viewModel.errorMessage = nil
            }
        } message: {
            Text(
                viewModel.errorMessage ?? ""
            )
        }
    }
}

// MARK: - UI

private extension LoginView {

    var logo: some View {

        ZStack {

            Circle()
                .fill(
                    Color.accentColor.opacity(0.12)
                )
                .frame(
                    width: 82,
                    height: 82
                )

            Image(systemName: "book.fill")
                .font(.system(size: 34))
                .foregroundStyle(Color.accentColor)
        }
    }

    var header: some View {

        VStack(spacing: 8) {

            Text("Welcome Back")
                .font(.system(
                    size: 30,
                    weight: .bold
                ))

            Text(
                "Continue your learning journey"
            )
            .font(.subheadline)
            .foregroundStyle(.secondary)
        }
    }

    var loginForm: some View {

        VStack(spacing: 16) {

            inputField(
                title: "Email",
                icon: "envelope",
                text: $viewModel.email,
                keyboard: .emailAddress
            )

            passwordField

            loginButton

            Text(
                "Use any non-empty email and password"
            )
            .font(.caption)
            .foregroundStyle(.secondary)
        }
    }

    func inputField(
        title: String,
        icon: String,
        text: Binding<String>,
        keyboard: UIKeyboardType
    ) -> some View {

        HStack(spacing: 12) {

            Image(systemName: icon)
                .foregroundStyle(.secondary)
                .frame(width: 22)

            TextField(
                title,
                text: text
            )
            .keyboardType(keyboard)
            .textInputAutocapitalization(.never)
            .autocorrectionDisabled()
        }
        .padding()
        .background(.thinMaterial)
        .clipShape(
            RoundedRectangle(
                cornerRadius: 14
            )
        )
        .overlay {
            RoundedRectangle(
                cornerRadius: 14
            )
            .stroke(
                Color.secondary.opacity(0.15)
            )
        }
    }

    var passwordField: some View {

        HStack(spacing: 12) {

            Image(systemName: "lock")
                .foregroundStyle(.secondary)
                .frame(width: 22)

            SecureField(
                "Password",
                text: $viewModel.password
            )
        }
        .padding()
        .background(.thinMaterial)
        .clipShape(
            RoundedRectangle(
                cornerRadius: 14
            )
        )
        .overlay {
            RoundedRectangle(
                cornerRadius: 14
            )
            .stroke(
                Color.secondary.opacity(0.15)
            )
        }
    }

    var loginButton: some View {

        Button {

            Task {

                let success =
                    await viewModel.login()

                if success {
                    onLoginSuccess()
                }
            }

        } label: {

            Group {

                if viewModel.isLoading {

                    ProgressView()
                        .tint(.white)

                } else {

                    Text("Sign In")
                        .fontWeight(.semibold)
                }
            }
            .frame(maxWidth: .infinity)
            .frame(height: 52)
        }
        .buttonStyle(.borderedProminent)
        .buttonBorderShape(.roundedRectangle(
            radius: 14
        ))
        .disabled(
            viewModel.isLoading
        )
    }
}
