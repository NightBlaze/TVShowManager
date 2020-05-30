//
//  RouterFactory.swift
//  TVShowManager
//
//  Created by Alexander Timonenkov on 30.05.2020.
//  Copyright © 2020 ATi Soft. All rights reserved.
//

import Foundation
import Swinject

protocol IRouterFactory: IFactory {
    func appStartRouterScenario() -> IAppStartRouterScenario
    func homeRouterScenario() -> IHomeRouterScenario
}

final class RouterFactory: IFactory {
    private let container: Container
    private let mainFactory: IMainFactory

    init(container: Container, mainFactory: IMainFactory) {
        self.container = container
        self.mainFactory = mainFactory
    }

    func register() {
        container.register(IRouter.self) { [unowned self] _ in
            let viewControllersFactory = self.mainFactory.viewControllersFactory()
            return Router(viewControllersFactory: viewControllersFactory)
        }
    }
}

// MARK: - IRouterFactory

extension RouterFactory: IRouterFactory {
    func appStartRouterScenario() -> IAppStartRouterScenario {
        return router() as IAppStartRouterScenario
    }

    func homeRouterScenario() -> IHomeRouterScenario {
        return router() as IHomeRouterScenario
    }
}

// MARK: - Private

private extension RouterFactory {
    func router() -> IRouter {
        return container.resolve(IRouter.self)!
    }
}
