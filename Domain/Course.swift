//
//  Course.swift
//  Course Dashboard
//
//  Created by Sameer Jain on 08/10/26.
//

import Foundation

struct Course: Identifiable, Equatable {
    let id: Int
    let title: String
    let instructor: String
    var lessons: [Lesson]

    var progress: Int {
        guard !lessons.isEmpty else {
            return 0
        }

        let completed = lessons.filter {
            $0.isCompleted
        }.count

        return Int(
            Double(completed) /
            Double(lessons.count) * 100
        )
    }

    var completedLessons: Int {
        lessons.filter {
            $0.isCompleted
        }.count
    }
}
