//
//  ScheduleViewModel.swift
//  Student View
//
//  Created by Daniel Castro on 2023-03-07.
//

import Foundation
import CoreData
import UIKit

class Coordinator: NSObject, UINavigationControllerDelegate,
    UIImagePickerControllerDelegate {
        
        private var isPreview: Bool = ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1"
        private let viewContext: NSManagedObjectContext
        
        private var picker: ImagePickerView
        
        init(picker: ImagePickerView) {
            viewContext = isPreview ? PersistenceController.preview.container.viewContext : PersistenceController.shared.container.viewContext
            self.picker = picker
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            guard let selectedImage = info[.originalImage] as? UIImage else {return}
            self.picker.selectedImage = selectedImage
            self.picker.isPresented.wrappedValue.dismiss()
        }
}
