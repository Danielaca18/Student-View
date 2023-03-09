//
//  ScheduleModel.swift
//  Student View
//
//  Created by Daniel Castro on 2023-03-07.
//

import Foundation
import CoreData
import UIKit

/// Schedule model object, representing coredata entity
public class Schedule: NSManagedObject {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Schedule> {
        return NSFetchRequest<Schedule>(entityName: "Schedule")
    }
    
    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var schedule: Data?
    
    /// Setting id attribute of model on start of object lifecycle
    public override func awakeFromInsert() {
        super.awakeFromInsert()
        id = UUID()
    }

}

extension Schedule : Identifiable {

}
