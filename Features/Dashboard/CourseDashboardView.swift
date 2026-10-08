//
//  CourseDashboardView.swift
//  Course Dashboard
//
//  Created by Sameer Jain on 08/10/26.
//

import SwiftUI

struct CourseDashboardView: View {

    @State private var viewModel:
        CourseDashboardViewModel

    let makeDetailView:
        (Course, @escaping () -> Void) -> CourseDetailView

    init(
        viewModel: CourseDashboardViewModel,
        makeDetailView:
            @escaping (Course, @escaping () -> Void) -> CourseDetailView
    ) {
        _viewModel = State(
            initialValue: viewModel
        )

        self.makeDetailView =
            makeDetailView
    }

    var body: some View {

        NavigationStack {

            ZStack {

                Color(.systemGroupedBackground)
                    .ignoresSafeArea()

                content
            }
            .navigationTitle("My Learning")
            .task {
                await viewModel.loadCourses()
            }
            .refreshable {
                await viewModel.loadCourses()
            }
        }
    }

    @ViewBuilder
    private var content: some View {

        if viewModel.isLoading &&
            viewModel.courses.isEmpty {

            ProgressView(
                "Loading courses..."
            )

        } else if viewModel.courses.isEmpty {

            emptyState

        } else {

            ScrollView {

                VStack(
                    alignment: .leading,
                    spacing: 20
                ) {

                    welcomeHeader

                    if viewModel.isShowingCachedCourses {
                        offlineNotice
                    }

                    courseList
                }
                .padding(20)
            }
        }
    }

    private var welcomeHeader: some View {

        VStack(
            alignment: .leading,
            spacing: 6
        ) {

            Text("Keep learning 🚀")
                .font(.title2)
                .fontWeight(.bold)

            Text(
                "Pick up where you left off."
            )
            .foregroundStyle(.secondary)
        }
    }

    private var offlineNotice: some View {

        Label(
            "Offline · Showing saved courses",
            systemImage: "wifi.slash"
        )
        .font(.footnote.weight(.medium))
        .foregroundStyle(.secondary)
        .padding(.horizontal, 12)
        .padding(.vertical, 9)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(.thinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }

    private var courseList: some View {

        LazyVStack(spacing: 14) {

            ForEach(viewModel.courses) { course in

                NavigationLink {

                    makeDetailView(course) {
                        Task {
                            await viewModel.loadCourses()
                        }
                    }

                } label: {

                    CourseCardView(
                        course: course
                    )
                }
                .buttonStyle(.plain)
            }
        }
    }

    private var emptyState: some View {

        ContentUnavailableView(
            "No Courses",
            systemImage: "book.closed",
            description: Text(
                "No courses are currently available."
            )
        )
    }
}
