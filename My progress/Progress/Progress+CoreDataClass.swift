//
//  Progress+CoreDataClass.swift
//  My progress
//
//  Created by Kovs on 29.07.2022.
//
//

import Foundation
import CoreData


public class Progress: NSManagedObject {
    @NSManaged public var value: Int
    @NSManaged public var progress: Int
    @NSManaged public var order: Int
}
