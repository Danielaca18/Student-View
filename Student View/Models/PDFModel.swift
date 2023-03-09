//
//  PDFModel.swift
//  Student View
//
//  Created by Daniel Castro on 2023-03-09.
//

import Foundation
import CoreData

/// PDF model object, representing coredata entity
public class PDF: NSManagedObject {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<PDF> {
        return NSFetchRequest<PDF>(entityName: "PDF")
    }
    
    @NSManaged public var name: String?
    @NSManaged public var file: Data?
    @NSManaged public var id: UUID?
    
    /// Setting id attribute of model on start of object lifecycle
    public override func awakeFromInsert() {
        super.awakeFromInsert()
        id = UUID()
    }
}

extension PDF : Identifiable {
    
}
