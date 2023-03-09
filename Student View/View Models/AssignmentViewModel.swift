//
//  AssignmentViewModel.swift
//  Student View
//
//  Created by Daniel Castro on 2023-03-06.
//

import Foundation
import CoreData
import SwiftUI

/**
 * Object manages assignment model and facilitates interaction with view
 */
class AssignmentViewModel: ObservableObject {
    @Published var assignments = [Assignment]()
    private var isPreview: Bool = ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1"
    private let viewContext: NSManagedObjectContext
    
    init() {
        viewContext = isPreview ? PersistenceController.preview.container.viewContext : PersistenceController.shared.container.viewContext
        fetchAssignments()
    }
    
    /**
     * adds assignment to coredata model
     * - Parameters:
     *  - title: the name of the assignment to be added
     *  - dueDate: the due data of the assignment to be added
     */
    func addAssignment(title: String, dueDate: Date) {
        withAnimation {
            let newAssignment = Assignment(context: viewContext)
            newAssignment.name = title
            newAssignment.dueDate = dueDate
            newAssignment.isComplete = false
            
            saveContext()
        }
    }
    
    /**
     * removes assignment from coredata model
     * - Parameters:
     *  - indexSet: the set of indices which are to be removed from the fetched assignments list
     */
    func deleteAssignment(at indexSet: IndexSet) {
        withAnimation {
            indexSet.forEach { index in
                let assignment = assignments[index]
                viewContext.delete(assignment)
            }
        }
        
        saveContext()
    }
    
    /**
     * toggle assignment is complete attribute and saves to coredata model
     * - Parameters:
     *  - index: index of assignment object in list which must be toggled
     */
    func toggleAssignmentCompletion(at index: Int) {
        withAnimation {
            let assignment = assignments[index]
            assignment.isComplete.toggle()
            saveContext()
        }
    }
    
    /**
     * fetches and stores assignments from core data
     */
    func fetchAssignments() {
        let request: NSFetchRequest<Assignment> = Assignment.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(keyPath: \Assignment.dueDate, ascending: true)]
        
        do {
            assignments = try viewContext.fetch(request)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    /**
     * saves any local changes into persistent stores
     */
    private func saveContext() {
        if isPreview {
            PersistenceController.preview.save()
            fetchAssignments()
        }
        else {
            PersistenceController.shared.save()
            fetchAssignments()
        }
    }
}
