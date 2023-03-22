//
//  CourseRowView.swift
//  Student View
//
//  Created by Daniel Castro on 2023-03-06.
//

import SwiftUI

/// View representing courses and handling user interaction
struct CourseRowView: View {
    @StateObject var course: Course
    @EnvironmentObject private var viewContext: CourseViewModel
    @State private var isEditing = false
    @State private var newName = ""
    @State private var newGpa = ""
    @State private var newCredit = ""
    
    var body: some View {
        HStack {
            if isEditing {
                TextField("Name", text: $newName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.leading)
                    .onAppear {
                        newName = course.name ?? ""
                    }
                    .onChange(of: newName) { newValue in
                        course.name = newValue
                    }
                    TextField("GPA", text: $newGpa)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.decimalPad)
                        .onAppear {
                            newGpa = "\(course.gpa)"
                        }
                        .onChange(of: newGpa) { newValue in
                            course.gpa = Double(newValue) ?? 0.0
                        }
                    TextField("Credit", text: $newCredit)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.decimalPad)
                        .onAppear {
                            newCredit = "\(course.credit)"
                        }
                        .onChange(of: newCredit) { newValue in
                            course.credit = Double(newValue) ?? 0.0
                        }
                    Button("Save") {
                        isEditing = false
                        viewContext.editCourse(course: course, name: newName, gpa: Double(newGpa) ?? 0.0, credit: Double(newCredit) ?? 0.0)
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                    }
            } else {
                VStack(alignment: .leading) {
                    Text(course.name ?? "")
                        .font(.headline)
                    Text("GPA: \(course.gpa, specifier: "%.1f") | Credit: \(course.credit, specifier: "%.0f")")
                        .font(.subheadline)
                }
                Spacer()
                Button("Edit") {
                    isEditing = true
                }
            }
        }
    }
}

struct CourseRowView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
