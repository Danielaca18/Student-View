//
//  DocumentPickerView.swift
//  Student View
//
//  Created by Daniel Castro on 2023-03-09.
//

import UIKit
import SwiftUI
import UniformTypeIdentifiers

/// View responsible for prompting user document selection
struct DocumentPickerView : UIViewControllerRepresentable {
    @Environment(\.presentationMode) var isPresented
    @EnvironmentObject private var viewModel: PDFViewModel
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<DocumentPickerView>) -> UIDocumentPickerViewController {
        let documentPicker = UIDocumentPickerViewController(forOpeningContentTypes: [UTType.pdf])
        documentPicker.allowsMultipleSelection = false
        documentPicker.delegate = viewModel
        return documentPicker
    }
    
    func updateUIViewController(_ uiViewController: UIDocumentPickerViewController, context: UIViewControllerRepresentableContext<DocumentPickerView>) {

    }
}
