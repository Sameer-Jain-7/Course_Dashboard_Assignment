//
//  Course_DashboardTests.swift
//  Course DashboardTests
//
//  Created by Sameer Jain on 08/10/26.
//

import Testing
@testable import Course_Dashboard

struct Course_DashboardTests {

    @Test func emptyCourseHasZeroProgress() {
        let course = Course(
            id: 1,
            title: "Python Programming",
            instructor: "John Smith",
            lessons: []
        )

        #expect(course.progress == 0)
        #expect(course.completedLessons == 0)
    }

    @Test func progressReflectsCompletedLessons() {
        let course = Course(
            id: 1,
            title: "Python Programming",
            instructor: "John Smith",
            lessons: [
                Lesson(id: 1, title: "Introduction", isCompleted: true),
                Lesson(id: 2, title: "Variables", isCompleted: false),
                Lesson(id: 3, title: "Functions", isCompleted: false),
                Lesson(id: 4, title: "Classes", isCompleted: false)
            ]
        )

        #expect(course.progress == 25)
        #expect(course.completedLessons == 1)
    }

    @Test func fullyCompletedCourseHasOneHundredPercentProgress() {
        let course = Course(
            id: 1,
            title: "Python Programming",
            instructor: "John Smith",
            lessons: [
                Lesson(id: 1, title: "Introduction", isCompleted: true),
                Lesson(id: 2, title: "Variables", isCompleted: true)
            ]
        )

        #expect(course.progress == 100)
        #expect(course.completedLessons == 2)
    }
}
