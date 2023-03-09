//
//  ContentView.swift
//  Student View
//
//  Created by Daniel Castro on 2023-03-06.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Assignment.dueDate, ascending: true)],
        animation: .default)
    private var assignments: FetchedResults<Assignment>

    var body: some View {
        TabView {
            ScheduleView()
                .environment(\.managedObjectContext, viewContext)
                .tabItem {
                    Label("Schedule", systemImage: "calendar.circle.fill")
                }
            AssignmentListView()
                .environment(\.managedObjectContext, viewContext)
                .tabItem {
                    Label("Assignments", systemImage: "tray.circle.fill")
                }
            CourseListView()
                .environment(\.managedObjectContext, viewContext)
                .tabItem {
                    Label("Courses", systemImage: "book.closed.circle.fill")
                }
            SyllabusView()
                            .environment(\.managedObjectContext, viewContext)
                            .tabItem {
                                Label("Syllabi", systemImage: "doc.circle.fill")
                            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
