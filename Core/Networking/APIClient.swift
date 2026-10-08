//
//  APIClient.swift
//  Course Dashboard
//
//  Created by Sameer Jain on 08/10/26.
//

import Foundation

protocol APIClient {
    func login(
        email: String,
        password: String
    ) async throws

    func fetchCourses() async throws -> [CourseDTO]
}
