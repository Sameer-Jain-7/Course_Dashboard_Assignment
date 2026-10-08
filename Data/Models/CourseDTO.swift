//
//  CourseDTO.swift
//  Course Dashboard
//
//  Created by Sameer Jain on 08/10/26.
//

import Foundation

struct CourseDTO: Codable {
    let id: Int
    let title: String
    let instructor: String
    let progress: Int
    let lessons: Int
}
