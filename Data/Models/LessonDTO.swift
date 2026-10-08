//
//  LessonDTO.swift
//  Course Dashboard
//
//  Created by Sameer Jain on 08/10/26.
//

import Foundation

struct LessonDTO: Codable {
    let id: Int
    let title: String
    let isCompleted: Bool
}
