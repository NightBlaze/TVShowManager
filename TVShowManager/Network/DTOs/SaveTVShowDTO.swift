//
//  SaveTVShowDTO.swift
//  TVShowManager
//
//  Created by Alexander Timonenkov on 31.05.2020.
//  Copyright © 2020 ATi Soft. All rights reserved.
//

import Foundation
import Parse

struct SaveTVShowDTO {
    private(set) var pfObject: PFObject

    init(dao: TVShowDAO) {
        pfObject = PFObject(className:"TVShow")
        pfObject["title"] = dao.title ?? ""
        pfObject["year"] = dao.year
        pfObject["seasons"] = dao.seasons
    }
}
