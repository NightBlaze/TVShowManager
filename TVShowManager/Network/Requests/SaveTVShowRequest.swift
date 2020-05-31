//
//  SaveTVShowRequest.swift
//  TVShowManager
//
//  Created by Alexander Timonenkov on 31.05.2020.
//  Copyright © 2020 ATi Soft. All rights reserved.
//

import Foundation
import Parse

struct SaveTVShowRequest {
    private(set) var pfObject: PFObject

    init(dao: TVShowDAO) {
        let dto = TVShowDTO(dao: dao)
        pfObject = dto.asPFObject()
    }
}
