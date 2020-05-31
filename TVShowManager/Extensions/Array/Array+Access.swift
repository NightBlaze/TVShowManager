//
//  Array+Access.swift
//  TVShowManager
//
//  Created by Alexander Timonenkov on 31.05.2020.
//  Copyright © 2020 ATi Soft. All rights reserved.
//

import Foundation

extension Array {
    func safeItem(at: Int) -> Element? {
        if at < 0 || at >= self.count {
            return nil
        }

        return self[at]
    }
}
