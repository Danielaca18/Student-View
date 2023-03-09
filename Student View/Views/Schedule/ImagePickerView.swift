//
//  ImagePickerView.swift
//  Student View
//
//  Created by Daniel Castro on 2023-03-07.
//

import UIKit
import SwiftUI

/// View responsible for user photo selection
struct ImagePickerView : UIViewControllerRepresentable {
    @Environment(\.presentationMode) var isPresented
    @EnvironmentObject private var viewModel: ScheduleViewModel
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = viewModel
        return imagePicker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {

    }
}
