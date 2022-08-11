//
//  Progress+CoreDataProperties.swift
//  My progress
//
//  Created by Kovs on 29.07.2022.
//
//

import Foundation
import CoreData


extension Progress {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Progress> {
        return NSFetchRequest<Progress>(entityName: "Progress")
    }

    @NSManaged public var name: String?
    
    @NSManaged public var dateEnd: Date?
    @NSManaged public var dateStart: Date?
    
    public var wrappedProgressName: String {
        name ?? "Unknown name"
    }
}

extension Progress : Identifiable {

}
