//
//  Course+CoreDataClass.swift
//  Student View
//
//  Created by Daniel Castro on 2023-03-06.
//
//

import Foundation
import CoreData


/// Course model object, representing coredata entity
public class Course: NSManagedObject {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Course> {
        return NSFetchRequest<Course>(entityName: "Course")
    }

    @NSManaged public var name: String?
    @NSManaged public var gpa: Double
    @NSManaged public var credit: Double
    @NSManaged public var id: UUID?

    /// Setting id attribute of model on start of object lifecycle
    public override func awakeFromInsert() {
            super.awakeFromInsert()
            id = UUID()
    }
}

extension Course : Identifiable {

}
