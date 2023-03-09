//
//  ScheduleViewModel.swift
//  Student View
//
//  Created by Daniel Castro on 2023-03-07.
//

import Foundation
import SwiftUI
import CoreData
import UIKit

/**
 * Object manages course model and facilitates interaction with view
 */
class ScheduleViewModel: NSObject, UINavigationControllerDelegate,
    UIImagePickerControllerDelegate, ObservableObject {
    @Published var schedule: [Schedule] = []
    private var isPreview: Bool = ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1"
    private var viewContext: NSManagedObjectContext
    
    private var picker: ImagePickerView?
    
    override init() {
        viewContext = isPreview ? PersistenceController.preview.container.viewContext : PersistenceController.shared.container.viewContext
        super.init()
        fetchSchedule()
        if schedule.isEmpty {
            let newSchedule = Schedule(context: viewContext)
            newSchedule.name = "Schedule"
            
            saveContext()
        }
    }
    
    /**
     * receives image picker results and stores result in coredata as binary data
     * - Parameters:
     *  - picker: The image picker controller which is utilized by the image picker view
     *  - info: The result of the users image selection
     */
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[.originalImage] as? UIImage else {return}
        schedule[0].schedule = selectedImage.jpegData(compressionQuality: 1.0)
        saveContext()
        picker.dismiss(animated: true, completion: nil)
    }
    
    /**
     * fetches and stores schedule object from coredata
     */
    func fetchSchedule() {
        do {
            schedule = try viewContext.fetch(Schedule.fetchRequest())
        } catch {
            print("Error fetching courses: \(error)")
        }
    }
    
    /**
     * stores image picker view into object for later use
     * - Parameters:
     *  - picker: The image picker view which will be displayed to user on addition of a schedule
     */
    func setPicker(picker: ImagePickerView) {
        self.picker = picker
    }
    
    /**
     * saves any local changes into persistent stores
     */
    private func saveContext() {
        objectWillChange.send()
        if isPreview {
            PersistenceController.preview.save()
            fetchSchedule()
        }
        else {
            PersistenceController.shared.save()
            fetchSchedule()
        }
    }
}
