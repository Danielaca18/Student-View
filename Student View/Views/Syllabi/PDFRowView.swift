//
//  PDFView.swift
//  Student View
//
//  Created by Daniel Castro on 2023-03-09.
//

import SwiftUI

/// View containing pdf kit view
struct PDFReadView: View {
    @EnvironmentObject private var viewModel: PDFViewModel
    let pdf: PDF
    
    var body: some View {
        VStack {
            PDFKitView(data: pdf.file ?? Data())
        }
        .navigationTitle(pdf.name ?? "Untitled")
        .onAppear {
            viewModel.fetchPDF()
        }
        .onDisappear {
            viewModel.fetchPDF()
        }
    }
}

struct PDFView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
