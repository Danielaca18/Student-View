//
//  AddCourseView.swift
//  Student View
//
//  Created by Daniel Castro on 2023-03-06.
//

import SwiftUI

/// View responsible for obtaining user input when adding a new course
struct AddCourseView: View {
    @Environment(\.presentationMode) private var isPresented
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject private var viewModel: CourseViewModel
    
    @State private var name = ""
    @State private var gpa = Double()
    @State private var credit = Double()
    
    private let decimalFormat: NumberFormatter = {
        let decimalFormat = NumberFormatter()
        decimalFormat.numberStyle = .decimal
        return decimalFormat
    }()
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Course Name", text: $name)
                TextField("Gpa", value: $gpa, formatter: decimalFormat)
                    .keyboardType(.decimalPad)
                TextField("Credit", value: $credit, formatter: decimalFormat)
                    .keyboardType(.numberPad)
            }
            .navigationBarTitle("Add Course")
            .navigationBarItems(trailing: Button("Save") {
                viewModel.addCourse(name: name, gpa: gpa, credit: credit)
                isPresented.wrappedValue.dismiss()
            })
        }
    }
}

struct AddCourseView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
