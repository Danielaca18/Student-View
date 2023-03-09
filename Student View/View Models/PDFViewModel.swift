//
//  PDFViewModel.swift
//  Student View
//
//  Created by Daniel Castro on 2023-03-09.
//

import Foundation
import SwiftUI
import CoreData
import UIKit

///
class PDFViewModel: NSObject, UINavigationControllerDelegate, UIDocumentPickerDelegate,
ObservableObject {
    @Published var pdfs: [PDF] = []
    private var isPreview: Bool = ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1"
    private var viewContext: NSManagedObjectContext
    
    private var picker: DocumentPickerView?
    
    override init() {
        viewContext = isPreview ? PersistenceController.preview.container.viewContext : PersistenceController.shared.container.viewContext
        super.init()
        fetchPDF()
    }
    
    /**
     * receives document picker results and stores result in coredata as binary data
     * - Parameters:
     *  - controller: The document picker controller which is utilized by the document picker view
     *  - urls: The result of the users document selection
     */
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        guard let fileURL = urls.first else {return}
        
        do {
            guard fileURL.startAccessingSecurityScopedResource() else {return}
            let name = fileURL.deletingPathExtension().lastPathComponent
            let file = try Data(contentsOf: fileURL)
            fileURL.stopAccessingSecurityScopedResource()
            
            addPDF(name: name, file: file)
        } catch {
            print("Error loading file: \(error)")
        }
        
        picker!.isPresented.wrappedValue.dismiss()
    }
    
    func addPDF(name: String, file: Data?) {
        let pdf = PDF(context: viewContext)
        pdf.name = name
        pdf.file = file
        
        saveContext()
    }
    
    func deletePDF(indexSet: IndexSet) {
        withAnimation {
            indexSet.forEach { index in
                let pdf = pdfs[index]
                viewContext.delete(pdf)
            }
        }
        
        saveContext()
    }
    
    func fetchPDF() {
        do {
            pdfs = try viewContext.fetch(PDF.fetchRequest())
        } catch {
            print("Error fetching pdfs: \(error)")
        }
    }
    
    func setPicker(picker: DocumentPickerView) {
        self.picker = picker
    }
    
    func saveContext() {
        objectWillChange.send()
        if isPreview {
            PersistenceController.preview.save()
            fetchPDF()
        } else {
            PersistenceController.shared.save()
            fetchPDF()
        }
    }
}
