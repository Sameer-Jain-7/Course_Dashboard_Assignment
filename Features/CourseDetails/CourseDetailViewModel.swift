//
//  CourseDetailViewModel.swift
//  Course Dashboard
//
//  Created by Sameer Jain on 08/10/26.
//

import Foundation
import Observation

@MainActor
@Observable
final class CourseDetailViewModel {

    private(set) var course: Course

    var errorMessage: String?

    private let repository:
        CourseRepositoryProtocol

    init(
        course: Course,
        repository: CourseRepositoryProtocol
    ) {
        self.course = course
        self.repository = repository
    }

    func markLessonCompleted(
        _ lesson: Lesson
    ) {

        guard !lesson.isCompleted else {
            return
        }

        do {

            try repository.markLessonCompleted(
                courseID: course.id,
                lessonID: lesson.id
            )

            updateLocalLesson(
                lesson.id
            )

        } catch {

            errorMessage =
                error.localizedDescription
        }
    }

    private func updateLocalLesson(
        _ lessonID: Int
    ) {

        guard let index =
            course.lessons.firstIndex(
                where: {
                    $0.id == lessonID
                }
            )
        else {
            return
        }

        course.lessons[index].isCompleted =
            true
    }
}
