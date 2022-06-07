//
//  Task+CoreDataProperties.swift
//  
//
//  Created by 김승찬 on 2022/06/07.
//
//

import Foundation
import CoreData


extension Task {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Task> {
        return NSFetchRequest<Task>(entityName: "Task")
    }

    @NSManaged public var color: Int64
    @NSManaged public var dueDate: Date?
    @NSManaged public var expectedTime: Int64
    @NSManaged public var name: String?
    @NSManaged public var tag: String?

}
