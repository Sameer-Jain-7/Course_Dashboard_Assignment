//
//  CourseCardView.swift
//  Course Dashboard
//
//  Created by Sameer Jain on 08/10/26.
//

import SwiftUI

struct CourseCardView: View {

    let course: Course

    var body: some View {

        VStack(
            alignment: .leading,
            spacing: 16
        ) {

            HStack {

                VStack(
                    alignment: .leading,
                    spacing: 5
                ) {

                    Text(course.title)
                        .font(.headline)

                    Text(course.instructor)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }

                Spacer()

                Image(systemName: "chevron.right")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }

            VStack(
                alignment: .leading,
                spacing: 8
            ) {

                HStack {

                    Text("Progress")

                    Spacer()

                    Text("\(course.progress)%")
                        .fontWeight(.semibold)
                }
                .font(.subheadline)

                ProgressView(
                    value: Double(course.progress),
                    total: 100
                )
                .tint(.accentColor)
            }

            HStack {

                Label(
                    "\(course.lessons.count) lessons",
                    systemImage: "book"
                )

                Spacer()

                Text(
                    course.progress == 100
                    ? "Completed"
                    : "Continue"
                )
                .font(.subheadline)
                .fontWeight(.semibold)
                .foregroundStyle(Color.accentColor)
            }
        }
        .padding(18)
        .background(
            Color(.white)
        )
        .clipShape(
            RoundedRectangle(
                cornerRadius: 18
            )
        )
    }
}
