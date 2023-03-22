//
//  CourseListView.swift
//  Student View
//
//  Created by Daniel Castro on 2023-03-06.
//

import SwiftUI


/// View representing the list of courses stored in coredata
struct CourseListView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @ObservedObject private var viewModel = CourseViewModel()
    
    @State private var showingAddCourse = false
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Cumulative GPA: \(viewModel.cGpa, specifier: "%.2f")")
                    .font(.headline)
                    .padding(.vertical)
                
                List {
                    ForEach(viewModel.courses, id: \.id) { course in
                        CourseRowView(course: course)
                            .environmentObject(viewModel)
                    }
                    .onDelete(perform: viewModel.deleteCourse)
                }
                .listStyle(InsetGroupedListStyle())
                .navigationBarTitle("Courses")
                .navigationBarItems(trailing: Button(action: {
                    showingAddCourse = true
                }) {
                    Image(systemName: "plus")
                }
                    .accessibility(label: Text("Add Course"))
                )
            }
        }
        .sheet(isPresented: $showingAddCourse) {
            AddCourseView()
                .environment(\.managedObjectContext, viewContext)
                .environmentObject(viewModel)
        }.onDisappear()
    }
}

struct CourseListView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
