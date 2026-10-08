//
//  CourseDashboardViewModel.swift
//  Course Dashboard
//
//  Created by Sameer Jain on 08/10/26.
//

import Foundation
import Observation

@MainActor
@Observable
final class CourseDashboardViewModel {

    var courses: [Course] = []

    var isLoading = false
    var isShowingCachedCourses = false
    var errorMessage: String?

    private let repository:
        CourseRepositoryProtocol

    init(
        repository: CourseRepositoryProtocol
    ) {
        self.repository = repository
    }

    func loadCourses() async {

        isLoading = true
        errorMessage = nil

        defer {
            isLoading = false
        }

        do {

            let result = try await repository.fetchCourses()
            courses = result.courses
            isShowingCachedCourses = result.source == .cache

        } catch {

            errorMessage =
                error.localizedDescription
        }
    }
}
