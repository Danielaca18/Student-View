//
//  SyllabusView.swift
//  Student View
//
//  Created by Daniel Castro on 2023-03-08.
//

import SwiftUI

struct SyllabusView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State private var showingDocumentPicker = false
    @ObservedObject var viewModel = PDFViewModel()
    
    private var picker = DocumentPickerView()
    
    init() {
        viewModel.setPicker(picker: picker)
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.pdfs, id:\.id) { pdf in
                    NavigationLink(destination: PDFReadView(pdf: pdf)
                        .environmentObject(viewModel)) {
                        Text(pdf.name ?? "Untitled")
                    }
                }
                .onDelete(perform: viewModel.deletePDF)
            }
            .navigationBarTitle("Syllabi")
            .navigationBarItems(trailing: Button(action: {
                showingDocumentPicker = true
            }) {
                Image(systemName: "plus")
            })
        }
        .sheet(isPresented: $showingDocumentPicker) {
            picker.environmentObject(viewModel)
                .onDisappear {
                    showingDocumentPicker = false
                }
        }
    }
}

struct SyllabusView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
