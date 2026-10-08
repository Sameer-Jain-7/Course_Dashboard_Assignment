//
//  Course_DashboardApp.swift
//  Course Dashboard
//
//  Created by Sameer Jain on 08/10/26.
//

import SwiftUI
import SwiftData

@main
struct LearningDashboardApp: App {

    private let modelContainer:
        ModelContainer

    private let apiClient:
        APIClient

    init() {

        do {

            modelContainer =
                try ModelContainer(
                    for:
                        CourseEntity.self,
                        LessonEntity.self
                )

        } catch {

            fatalError(
                "Failed to create ModelContainer: \(error)"
            )
        }

        apiClient = MockAPIClient()
    }

    var body: some Scene {

        WindowGroup {

            RootView(
                modelContainer: modelContainer,
                apiClient: apiClient
            )
        }
        .modelContainer(
            modelContainer
        )
    }
}
