//
//  PDFKitView.swift
//  Student View
//
//  Created by Daniel Castro on 2023-03-09.
//

import SwiftUI
import PDFKit

/// View responsible for displaying pdf documents to users
struct PDFKitView: UIViewRepresentable {
    let data: Data
    
    func makeUIView(context: UIViewRepresentableContext<PDFKitView>) -> PDFKitView.UIViewType {
        let pdfView = PDFView()
        pdfView.document = PDFDocument(data: data)
        pdfView.autoScales = true
        return pdfView
    }
    
    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<PDFKitView>) {
        guard let pdfView = uiView as? PDFView else {return}
        pdfView.document = PDFDocument(data: data)
    }
}
