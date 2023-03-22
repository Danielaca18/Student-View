//
//  ScheduleView.swift
//  Student View
//
//  Created by Daniel Castro on 2023-03-07.
//

import SwiftUI

/// View representing the schedule object stored in coredata
struct ScheduleView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State private var showingChangeSchedule = false
    @StateObject private var viewModel = ScheduleViewModel()
    //@State private var selectedImage: UIImage?
    private var picker = ImagePickerView()
    
    init() {
        viewModel.setPicker(picker: picker)
    }
    
    var body: some View {
            NavigationView {
                if viewModel.schedule[0].schedule != nil {
                    GeometryReader { geometry in
                        VStack {
                            Spacer()
                            Image(uiImage: UIImage(data: viewModel.schedule[0].schedule!)!)
                                .resizable()
                                .scaledToFit()
                            Spacer()
                        }
                        .padding()
                        .navigationTitle("Class Schedule")
                        .toolbar {
                            ToolbarItem(placement: .navigationBarTrailing) {
                                Button(action: {
                                    showingChangeSchedule = true
                                }) {
                                    Image(systemName: "plus")
                                }
                            }
                        }
                    }
                } else {
                    VStack(spacing: 20) {
                        Spacer()
                        Text("No class schedule found")
                            .font(.headline)
                        Spacer()
                    }
                    .navigationTitle("Class Schedule")
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button(action: {
                                showingChangeSchedule = true
                            }) {
                                Image(systemName: "plus")
                            }
                        }
                    }
                }
            }
            .sheet(isPresented: $showingChangeSchedule) {
                picker.environmentObject(viewModel)
                    .onDisappear {
                        showingChangeSchedule = false
                    }
            }
        }
}

struct ScheduleView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
