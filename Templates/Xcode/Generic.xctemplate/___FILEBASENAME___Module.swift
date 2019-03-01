//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created ___FULLUSERNAME___ on ___DATE___.
//  Copyright © ___YEAR___ ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation
import UIKit

// MARK: - router

protocol ___VARIABLE_MODULE_NAME___RouterPresenterInterface: RouterPresenterInterface {


}

// MARK: - presenter

protocol ___VARIABLE_MODULE_NAME___PresenterRouterInterface: PresenterRouterInterface {


}

protocol ___VARIABLE_MODULE_NAME___PresenterInteractorInterface: PresenterInteractorInterface {


}

protocol ___VARIABLE_MODULE_NAME___PresenterViewInterface: PresenterViewInterface {


}

// MARK: - interactor

protocol ___VARIABLE_MODULE_NAME___InteractorPresenterInterface: InteractorPresenterInterface {


}

// MARK: - view

protocol ___VARIABLE_MODULE_NAME___ViewPresenterInterface: ViewPresenterInterface {


}

// MARK: - module builder

class ___VARIABLE_MODULE_NAME___Module: GenericModuleInterface {

    typealias View = ___VARIABLE_MODULE_NAME___View
    typealias Presenter = ___VARIABLE_MODULE_NAME___Presenter
    typealias Router = ___VARIABLE_MODULE_NAME___Router
    typealias Interactor = ___VARIABLE_MODULE_NAME___Interactor

    func build() -> UIViewController {
        let view = View()
        let interactor = Interactor()
        let presenter = Presenter()
        let router = Router()

        self.compose(view: view, presenter: presenter, router: router, interactor: interactor)

        router.viewController = view

        return view
    }
}
