//
//  FetchTVShowRequest.swift
//  TVShowManager
//
//  Created by Alexander Timonenkov on 31.05.2020.
//  Copyright © 2020 ATi Soft. All rights reserved.
//

import Foundation
import Parse

struct FetchTVShowRequest {
    private(set) var pfQuery: PFQuery<PFObject>

    init(predicate: NSPredicate?) {
        pfQuery = PFQuery(className: TVShowDTO.className, predicate: predicate)
    }
}
