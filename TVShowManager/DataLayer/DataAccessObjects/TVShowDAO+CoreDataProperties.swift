//
//  TVShowDAO+CoreDataProperties.swift
//  TVShowManager
//
//  Created by Alexander Timonenkov on 31.05.2020.
//  Copyright © 2020 ATi Soft. All rights reserved.
//
//

import Foundation
import CoreData


extension TVShowDAO {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TVShowDAO> {
        return NSFetchRequest<TVShowDAO>(entityName: "TVShowDAO")
    }

    @NSManaged public var title: String?
    @NSManaged public var year: Int32
    @NSManaged public var seasons: Int32
    @NSManaged public var id: UUID?
    @NSManaged public var createdDate: Date?

}
