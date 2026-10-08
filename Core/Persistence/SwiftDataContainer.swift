//
//  SwiftDataContainer.swift
//  Course Dashboard
//
//  Created by Sameer Jain on 08/10/26.
//

import Foundation
import SwiftData

@Model
final class CourseEntity {
    @Attribute(.unique)
    var id: Int

    var title: String
    var instructor: String

    @Relationship(
        deleteRule: .cascade,
        inverse: \LessonEntity.course
    )
    var lessons: [LessonEntity]

    init(
        id: Int,
        title: String,
        instructor: String,
        lessons: [LessonEntity] = []
    ) {
        self.id = id
        self.title = title
        self.instructor = instructor
        self.lessons = lessons
    }
}

@Model
final class LessonEntity {
    @Attribute(.unique)
    var id: Int

    var title: String
    var isCompleted: Bool

    var course: CourseEntity?

    init(
        id: Int,
        title: String,
        isCompleted: Bool = false
    ) {
        self.id = id
        self.title = title
        self.isCompleted = isCompleted
    }
}
