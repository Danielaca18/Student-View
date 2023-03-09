//
//  Assignment+CoreDataClass.swift
//  Student View
//
//  Created by Daniel Castro on 2023-03-06.
//
//

import Foundation
import CoreData


public class Assignment: NSManagedObject {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Assignment> {
        return NSFetchRequest<Assignment>(entityName: "Assignment")
    }

    @NSManaged public var dueDate: Date?
    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var isComplete: Bool
    
    public override func awakeFromInsert() {
            super.awakeFromInsert()
            id = UUID()
    }
}

extension Assignment : Identifiable {

}
