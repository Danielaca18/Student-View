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
    @State private var gpa = ""
    @State private var credit = ""
    
    private let decimalFormat: NumberFormatter = {
        let decimalFormat = NumberFormatter()
        decimalFormat.numberStyle = .decimal
        return decimalFormat
    }()
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Course Details")) {
                    TextField("Enter the course name", text: $name)
                    TextField("Enter your gpa", text: $gpa)
                        .keyboardType(.decimalPad)
                    TextField("Enter your credits", text: $credit)
                        .keyboardType(.numberPad)
                }
            }
            .navigationBarTitle("Add Course")
            .navigationBarItems(trailing:
                Button(action: {
                viewModel.addCourse(name: name, gpa: Double(gpa) ?? 0, credit: Double(credit) ?? 0)
                    isPresented.wrappedValue.dismiss()
                }) {
                    Text("Save")
                        .fontWeight(.bold)
                }
                .accessibility(label: Text("Save Course"))
            )
        }
    }
}

struct AddCourseView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
