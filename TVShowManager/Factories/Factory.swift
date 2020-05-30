//
//  Factory.swift
//  TVShowManager
//
//  Created by Alexander Timonenkov on 30.05.2020.
//  Copyright © 2020 ATi Soft. All rights reserved.
//

import Foundation
import Swinject

protocol IFactory {
    func register()
}

final class Factory: IFactory {
    private let container = Container()

    func register() {
    }
}
