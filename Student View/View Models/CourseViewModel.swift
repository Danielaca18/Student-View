//
//  CourseViewModel.swift
//  Student View
//
//  Created by Daniel Castro on 2023-03-06.
//

import Foundation
import CoreData
import SwiftUI

/**
 * Object manages course model and facilitates interaction with view
 */
class CourseViewModel: ObservableObject {
    @Published var courses: [Course] = []
    @Published var cGpa: Double = 0
    
    private var isPreview: Bool = ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1"
    private let viewContext: NSManagedObjectContext
    
    init() {
        viewContext = isPreview ? PersistenceController.preview.container.viewContext : PersistenceController.shared.container.viewContext
        fetchCourses()
        calculateCumulativeGpa()
    }
    
    /**
     * adds course to coredata model
     * - Parameters:
     *  - name: the name of the course to be added
     *  - gpa: the gpa received in course to be added
     *  - credit: the number of credits received in course to be added
     */
    func addCourse(name: String, gpa: Double, credit: Double) {
        let course = Course(context: viewContext)
        course.name = name
        course.gpa = gpa
        course.credit = credit
        
        saveContext()
    }
    
    /**
     * edits course object attributes and updates changes in coredata model
     * - Parameters:
     *  - course: the course object which will be edited
     *  - name: the new name for the course
     *  - gpa: the new gpa for the course
     *  - credit: the new credit for the course
     */
    func editCourse(course: Course, name: String, gpa: Double, credit: Double) {
        course.name = name
        course.gpa = gpa
        course.credit = credit
        
        saveContext()
    }
    
    /**
     * removes course from coredata model
     * - Parameters:
     *  - indexSet: the set of indices to remove from the fetched assignment list
     */
    func deleteCourse(indexSet: IndexSet) {
        withAnimation {
            indexSet.forEach { index in
                let course = courses[index]
                viewContext.delete(course)
            }
        }
        
        saveContext()
    }
    /**
     * calculates and stores cumulative gpa derived from fetched course list
     */
    func calculateCumulativeGpa() {
        objectWillChange.send()
        let totalCredit = courses.reduce(0, {$0 + $1.credit})
        guard totalCredit > 0 else {
            cGpa = 0.0
            return
        }
        
        let totalGP = courses.reduce(0, {$0 + ($1.gpa * $1.credit)})
        cGpa = totalGP / totalCredit
        
        print("Credits :\(totalCredit)")
        print("Grade Points: \(totalGP)")
        print("Gpa: \(cGpa)")
    }
    
    /**
     * fetches and stores course object from coredata
     */
    func fetchCourses() {
        do {
            courses = try viewContext.fetch(Course.fetchRequest())
        } catch {
            print("Error fetching courses: \(error)")
        }
    }
    
    /**
     * saves any local changes into persistent stores
     */
    private func saveContext() {
        objectWillChange.send()
        if isPreview {
            PersistenceController.preview.save()
            fetchCourses()
        }
        else {
            PersistenceController.shared.save()
            fetchCourses()
        }
        
        calculateCumulativeGpa()
    }
}
