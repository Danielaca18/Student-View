//
//  AssignmentListView.swift
//  Student View
//
//  Created by Daniel Castro on 2023-03-06.
//

import SwiftUI

/// View representing the list of assignments stored in coredata
struct AssignmentListView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @ObservedObject var viewModel = AssignmentViewModel()
    
    @State private var showingAddAssignment = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.assignments, id: \.id) { assignment in
                    AssignmentRowView(assignment: assignment).environmentObject(viewModel)
                }
                .onDelete(perform: viewModel.deleteAssignment)
            }
            .listStyle(PlainListStyle())
            .navigationBarTitle("Assignments")
            .navigationBarItems(trailing: Button(action: {
                showingAddAssignment = true
            }) {
                Image(systemName: "plus")
            }
                .accessibility(label: Text("Add Assignment"))
            )
        }
        .sheet(isPresented: $showingAddAssignment) {
            AddAssignmentView()
                .environment(\.managedObjectContext, viewContext)
                .environmentObject(viewModel)
        }.onDisappear()
    }
}

struct AssignmentListView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
