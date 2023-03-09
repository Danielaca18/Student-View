//
//  AssignmentRowView.swift
//  Student View
//
//  Created by Daniel Castro on 2023-03-06.
//

import SwiftUI

struct AssignmentRowView: View {
    let assignment: Assignment
    @EnvironmentObject var viewModel: AssignmentViewModel
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(assignment.name)
                    .font(.headline)
                Text(assignment.dueDate, style: .date)
                    .foregroundColor(.secondary)
            }
            Spacer()
            if assignment.isComplete {
                Image(systemName: "checkmark")
                    .foregroundColor(.green)
            }
        }
        .onTapGesture {
            viewModel.toggleAssignmentCompletion(at: viewModel.assignments.firstIndex(of: assignment)!)
        }
        .onAppear {
            viewModel.fetchAssignments()
        }
    }
}

struct AssignmentRowView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
