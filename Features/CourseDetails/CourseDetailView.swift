//
//  CourseDetailView.swift
//  Course Dashboard
//
//  Created by Sameer Jain on 08/10/26.
//

import SwiftUI

struct CourseDetailView: View {

    @State private var viewModel:
        CourseDetailViewModel

    let onReturn: () -> Void

    init(
        viewModel: CourseDetailViewModel,
        onReturn: @escaping () -> Void = {}
    ) {
        _viewModel = State(
            initialValue: viewModel
        )
        self.onReturn = onReturn
    }

    var body: some View {

        ScrollView {

            VStack(
                alignment: .leading,
                spacing: 24
            ) {

                progressHeader

                lessonsSection
            }
            .padding(20)
        }
        .background(
            Color(.systemGroupedBackground)
        )
        .onDisappear(perform: onReturn)
        .navigationTitle(
            viewModel.course.title
        )
        .navigationBarTitleDisplayMode(.inline)
        .alert(
            "Something went wrong",
            isPresented: Binding(
                get: {
                    viewModel.errorMessage != nil
                },
                set: { value in
                    if !value {
                        viewModel.errorMessage = nil
                    }
                }
            )
        ) {
            Button("OK") {
                viewModel.errorMessage = nil
            }
        } message: {
            Text(
                viewModel.errorMessage ?? ""
            )
        }
    }
}

// MARK: - UI

private extension CourseDetailView {

    var progressHeader: some View {

        VStack(
            alignment: .leading,
            spacing: 18
        ) {

            HStack {

                VStack(
                    alignment: .leading,
                    spacing: 6
                ) {

                    Text(
                        viewModel.course.title
                    )
                    .font(.title2)
                    .fontWeight(.bold)

                    Text(
                        viewModel.course.instructor
                    )
                    .foregroundStyle(.secondary)
                }

                Spacer()
            }

            HStack {

                VStack(
                    alignment: .leading
                ) {

                    Text(
                        "\(viewModel.course.progress)%"
                    )
                    .font(.system(
                        size: 34,
                        weight: .bold
                    ))

                    Text("Complete")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }

                Spacer()

                Text(
                    "\(viewModel.course.completedLessons)/" +
                    "\(viewModel.course.lessons.count)"
                )
                .font(.headline)
            }

            ProgressView(
                value: Double(
                    viewModel.course.progress
                ),
                total: 100
            )
            .tint(.accentColor)
        }
        .padding(20)
        .background(.background)
        .clipShape(
            RoundedRectangle(
                cornerRadius: 20
            )
        )
    }

    var lessonsSection: some View {

        VStack(
            alignment: .leading,
            spacing: 14
        ) {

            Text("Lessons")
                .font(.title3)
                .fontWeight(.bold)

            ForEach(
                viewModel.course.lessons.sorted {
                    $0.id < $1.id
                }
            ) { lesson in

                lessonRow(lesson)
            }
        }
    }

    func lessonRow(
        _ lesson: Lesson
    ) -> some View {

        HStack(spacing: 14) {

            Image(
                systemName:
                    lesson.isCompleted
                    ? "checkmark.circle.fill"
                    : "circle"
            )
            .font(.title3)
            .foregroundStyle(
                lesson.isCompleted
                ? .green
                : .secondary
            )

            VStack(
                alignment: .leading,
                spacing: 4
            ) {

                Text(lesson.title)
                    .fontWeight(.medium)

                Text(
                    lesson.isCompleted
                    ? "Completed"
                    : "Pending"
                )
                .font(.caption)
                .foregroundStyle(.secondary)
            }

            Spacer()

            if !lesson.isCompleted {

                Button("Complete") {

                    viewModel
                        .markLessonCompleted(
                            lesson
                        )
                }
                .font(.caption)
                .fontWeight(.semibold)
                .buttonStyle(.bordered)
            }
        }
        .padding(16)
        .background(.background)
        .clipShape(
            RoundedRectangle(
                cornerRadius: 16
            )
        )
    }
}
