//
//  CourseRepository.swift
//  Course Dashboard
//
//  Created by Sameer Jain on 08/10/26.
//

import Foundation
import SwiftData

protocol CourseRepositoryProtocol {
    func fetchCourses() async throws -> CourseFetchResult
    func markLessonCompleted(
        courseID: Int,
        lessonID: Int
    ) throws
}

struct CourseFetchResult {
    let courses: [Course]
    let source: Source

    enum Source: Equatable {
        case remote
        case cache
    }
}

@MainActor
final class CourseRepository: CourseRepositoryProtocol {

    private let apiClient: APIClient
    private let context: ModelContext

    init(
        apiClient: APIClient,
        context: ModelContext
    ) {
        self.apiClient = apiClient
        self.context = context
    }

    func fetchCourses() async throws -> CourseFetchResult {

        do {
            let remoteCourses = try await apiClient.fetchCourses()

            let courses = remoteCourses.map {
                makeDomainCourse(from: $0)
            }

            try saveToLocal(courses)

            // The remote response describes course contents, while completion
            // state is stored locally. Read back the saved models so a refresh
            // does not replace completed lessons with the remote defaults.
            return CourseFetchResult(
                courses: try fetchCachedCourses(),
                source: .remote
            )

        } catch {
            let cached = try fetchCachedCourses()

            if !cached.isEmpty {
                return CourseFetchResult(
                    courses: cached,
                    source: .cache
                )
            }

            throw error
        }
    }

    func markLessonCompleted(
        courseID: Int,
        lessonID: Int
    ) throws {

        let descriptor = FetchDescriptor<CourseEntity>(
            predicate: #Predicate {
                $0.id == courseID
            }
        )

        guard let course = try context.fetch(
            descriptor
        ).first else {
            throw AppError.persistence
        }

        guard let lesson = course.lessons.first(
            where: { $0.id == lessonID }
        ) else {
            throw AppError.persistence
        }

        lesson.isCompleted = true

        try context.save()
    }
}

// MARK: - Mapping

private extension CourseRepository {

    func makeDomainCourse(
        from dto: CourseDTO
    ) -> Course {

        let lessons = (1...dto.lessons).map {
            Lesson(
                id: dto.id * 1000 + $0,
                title: lessonTitle(
                    course: dto.title,
                    index: $0
                ),
                isCompleted: false
            )
        }

        return Course(
            id: dto.id,
            title: dto.title,
            instructor: dto.instructor,
            lessons: lessons
        )
    }

    func lessonTitle(
        course: String,
        index: Int
    ) -> String {

        let titles = [
            "Introduction",
            "Variables & Data Types",
            "Functions",
            "Object Oriented Programming"
        ]

        if index <= titles.count {
            return titles[index - 1]
        }

        return "\(course) - Lesson \(index)"
    }
}

// MARK: - Persistence

private extension CourseRepository {

    func saveToLocal(
        _ courses: [Course]
    ) throws {

        for course in courses {

            let courseID = course.id

            let descriptor =
                FetchDescriptor<CourseEntity>(
                    predicate: #Predicate {
                        $0.id == courseID
                    }
                )
            
            let existing = try context.fetch(
                descriptor
            ).first

            let entity = existing ??
                CourseEntity(
                    id: course.id,
                    title: course.title,
                    instructor: course.instructor
                )

            entity.title = course.title
            entity.instructor = course.instructor

            if existing == nil {
                context.insert(entity)
            }

            if entity.lessons.isEmpty {
                entity.lessons = course.lessons.map {
                    LessonEntity(
                        id: $0.id,
                        title: $0.title,
                        isCompleted: $0.isCompleted
                    )
                }
            }
        }

        try context.save()
    }

    func fetchCachedCourses() throws -> [Course] {

        let descriptor =
            FetchDescriptor<CourseEntity>(
                sortBy: [
                    SortDescriptor(\.id)
                ]
            )

        let entities = try context.fetch(
            descriptor
        )

        return entities.map { entity in

            let lessons = entity.lessons
                .sorted { $0.id < $1.id }
                .map {
                Lesson(
                    id: $0.id,
                    title: $0.title,
                    isCompleted: $0.isCompleted
                )
                }

            return Course(
                id: entity.id,
                title: entity.title,
                instructor: entity.instructor,
                lessons: lessons
            )
        }
    }
}
