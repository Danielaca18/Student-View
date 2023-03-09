//
//  Student_ViewApp.swift
//  Student View
//
//  Created by Daniel Castro on 2023-03-06.
//

import SwiftUI

@main
/// Application used to manage basic information relevant to students
struct Student_ViewApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
