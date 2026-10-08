//
//  ContentView.swift
//  Course Dashboard
//
//  Created by Sameer Jain on 08/10/26.
//

import SwiftUI
import SwiftData

struct RootView: View {

    let modelContainer: ModelContainer
    let apiClient: APIClient

    @State private var isLoggedIn = false

    var body: some View {

        Group {
            if isLoggedIn {

                dashboard

            } else {

                login
            }
        }
        .tint(Color.accentColor)
    }

    private var login: some View {

        LoginView(
            viewModel: LoginViewModel(
                repository: AuthRepository(
                    apiClient: apiClient
                )
            )
        ) {

            withAnimation {
                isLoggedIn = true
            }
        }
    }

    private var dashboard: some View {

        let context =
            modelContainer.mainContext

        let repository =
            CourseRepository(
                apiClient: apiClient,
                context: context
            )

        return CourseDashboardView(
            viewModel:
                CourseDashboardViewModel(
                    repository: repository
                )
        ) { course, onReturn in

            CourseDetailView(
                viewModel:
                    CourseDetailViewModel(
                        course: course,
                        repository: repository
                    ),
                onReturn: onReturn
            )
        }
    }
}
