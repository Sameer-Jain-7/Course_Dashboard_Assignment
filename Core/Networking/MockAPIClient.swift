//
//  MockAPIClient.swift
//  Course Dashboard
//
//  Created by Sameer Jain on 08/10/26.
//

import Foundation

final class MockAPIClient: APIClient {

    func login(
        email: String,
        password: String
    ) async throws {
        try await Task.sleep(
            for: .milliseconds(700)
        )

        guard !email.isEmpty,
              !password.isEmpty else {
            throw AppError.invalidCredentials
        }
    }

    func fetchCourses() async throws -> [CourseDTO] {
        if ProcessInfo.processInfo.arguments.contains("-simulateOffline") {
            throw AppError.network
        }

        try await Task.sleep(
            for: .milliseconds(800)
        )

        let courses = [
            CourseDTO(
                id: 1,
                title: "Python Programming",
                instructor: "John Smith",
                progress: 65,
                lessons: 20
            ),

            CourseDTO(
                id: 2,
                title: "Generative AI",
                instructor: "Sarah Williams",
                progress: 40,
                lessons: 16
            ),

            CourseDTO(
                id: 3,
                title: "Full Stack Development",
                instructor: "David Brown",
                progress: 25,
                lessons: 28
            ),

            CourseDTO(
                id: 4,
                title: "iOS App Development",
                instructor: "Emily Chen",
                progress: 10,
                lessons: 24
            ),

            CourseDTO(
                id: 5,
                title: "Data Structures & Algorithms",
                instructor: "Michael Patel",
                progress: 35,
                lessons: 32
            ),

            CourseDTO(
                id: 6,
                title: "UI/UX Design Fundamentals",
                instructor: "Ava Thompson",
                progress: 50,
                lessons: 18
            ),

            CourseDTO(
                id: 7,
                title: "Machine Learning",
                instructor: "Noah Williams",
                progress: 5,
                lessons: 30
            ),

            CourseDTO(
                id: 8,
                title: "Cloud Computing with AWS",
                instructor: "Sophia Garcia",
                progress: 70,
                lessons: 22
            ),

            CourseDTO(
                id: 9,
                title: "Cybersecurity Essentials",
                instructor: "Liam Johnson",
                progress: 15,
                lessons: 26
            ),

            CourseDTO(
                id: 10,
                title: "Product Management",
                instructor: "Olivia Martinez",
                progress: 45,
                lessons: 16
            )
        ]

        if ProcessInfo.processInfo.arguments.contains("-simulatePartialCatalog") {
            return Array(courses.prefix((courses.count + 1) / 2))
        }

        return courses
    }
}
