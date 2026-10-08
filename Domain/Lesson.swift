//
//  Lesson.swift
//  Course Dashboard
//
//  Created by Sameer Jain on 08/10/26.
//

import Foundation

struct Lesson: Identifiable, Equatable {
    let id: Int
    let title: String
    var isCompleted: Bool
}
