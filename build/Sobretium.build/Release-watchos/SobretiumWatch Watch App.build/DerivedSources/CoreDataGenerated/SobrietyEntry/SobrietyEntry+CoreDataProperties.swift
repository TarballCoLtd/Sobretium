//
//  SobrietyEntry+CoreDataProperties.swift
//  
//
//  Created by Tarball on 10/9/22.
//
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData


extension SobrietyEntry {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SobrietyEntry> {
        return NSFetchRequest<SobrietyEntry>(entityName: "SobrietyEntry")
    }

    @NSManaged public var defaultEntry: Bool
    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var startDate: Date?
    @NSManaged public var subtitle: String?
    @NSManaged public var themeIndex: Int32

}

extension SobrietyEntry : Identifiable {

}
