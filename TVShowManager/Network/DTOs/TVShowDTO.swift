//
//  TVShowDTO.swift
//  TVShowManager
//
//  Created by Alexander Timonenkov on 31.05.2020.
//  Copyright © 2020 ATi Soft. All rights reserved.
//

import Foundation
import Parse

struct TVShowDTO {
    static var className: String { "TVShow" }

    private enum Fields: String {
        case title = "title"
        case year = "year"
        case seasons = "seasons"
    }

    let objectId: String?
    let title: String
    let year: Int
    let seasons: Int

    init(pfObject: PFObject) {
        objectId = pfObject.objectId
        title = (pfObject[Fields.title.rawValue] as? String) ?? ""
        year = (pfObject[Fields.year.rawValue] as? Int) ?? 0
        seasons = (pfObject[Fields.seasons.rawValue] as? Int) ?? 0
    }

    init(dao: TVShowDAO) {
        objectId = dao.externalId
        title = dao.title ?? ""
        year = Int(dao.year)
        seasons = Int(dao.seasons)
    }

    func asPFObject() -> PFObject {
        let pfObject = PFObject(className: TVShowDTO.className)
        pfObject.objectId = objectId
        pfObject[TVShowDTO.Fields.title.rawValue] = title
        pfObject[TVShowDTO.Fields.year.rawValue] = year
        pfObject[TVShowDTO.Fields.seasons.rawValue] = seasons

        return pfObject
    }
}
