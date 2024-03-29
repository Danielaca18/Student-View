//
//  AddAssignmentView.swift
//  Student View
//
//  Created by Daniel Castro on 2023-03-06.
//

import SwiftUI


/// View responsible for obtaining user input when adding a new assignment
struct AddAssignmentView: View {
    @Environment(\.presentationMode) private var isPresented
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject private var viewModel: AssignmentViewModel
    
    @State private var title = ""
    @State private var dueDate = Date()
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Assignment Details")) {
                    TextField("Title", text: $title)
                    DatePicker(
                        "Due Date",
                        selection: $dueDate,
                        displayedComponents: .date
                    )
                }
            }
            .navigationBarTitle("Add Assignment")
            .navigationBarItems(trailing:
                Button(action: {
                    viewModel.addAssignment(title: title, dueDate: dueDate)
                    isPresented.wrappedValue.dismiss()
                }) {
                    Text("Save")
                        .fontWeight(.bold)
                }
                .accessibility(label: Text("Save Assignment"))
            )
        }
    }
}

struct AddAssignmentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
