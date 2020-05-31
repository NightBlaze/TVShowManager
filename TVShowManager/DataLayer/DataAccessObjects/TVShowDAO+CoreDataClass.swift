//
//  TVShowDAO+CoreDataClass.swift
//  TVShowManager
//
//  Created by Alexander Timonenkov on 31.05.2020.
//  Copyright © 2020 ATi Soft. All rights reserved.
//
//

import Foundation
import CoreData

@objc(TVShowDAO)
public class TVShowDAO: NSManagedObject {
    class func create(title: String, year: Int32, seasons: Int32, externalId: String?, context: NSManagedObjectContext) -> TVShowDAO {
        let tvShow = TVShowDAO(entity: TVShowDAO.entity(), insertInto: context)
        tvShow.id = UUID()
        tvShow.title = title
        tvShow.year = year
        tvShow.seasons = seasons
        tvShow.externalId = externalId
        tvShow.createdDate = Date()
        return tvShow
    }
}
