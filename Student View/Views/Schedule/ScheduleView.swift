//
//  ScheduleView.swift
//  Student View
//
//  Created by Daniel Castro on 2023-03-07.
//

import SwiftUI

struct ScheduleView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    var body: some View {
        NavigationView {
            
        }
    }
}

struct ScheduleView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
