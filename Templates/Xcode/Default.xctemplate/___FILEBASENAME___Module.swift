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

protocol ___VARIABLE_MODULE_NAME___RouterInterface: RouterInterface &
                              ___VARIABLE_MODULE_NAME___RouterPresenterInterface {
    var presenter: ___VARIABLE_MODULE_NAME___PresenterRouterInterface? { get }

}

// MARK: - interactor

protocol ___VARIABLE_MODULE_NAME___InteractorPresenterInterface: InteractorPresenterInterface {

}

protocol ___VARIABLE_MODULE_NAME___InteractorInterface: InteractorInterface &
                                  ___VARIABLE_MODULE_NAME___InteractorPresenterInterface {
    var presenter: ___VARIABLE_MODULE_NAME___PresenterInteractorInterface? { get }

}

// MARK: - presenter

protocol ___VARIABLE_MODULE_NAME___PresenterRouterInterface: PresenterRouterInterface {

}

protocol ___VARIABLE_MODULE_NAME___PresenterInteractorInterface: PresenterInteractorInterface {

}

protocol ___VARIABLE_MODULE_NAME___PresenterViewInterface: PresenterViewInterface {

}

protocol ___VARIABLE_MODULE_NAME___PresenterInterface: PresenterInterface &
                                 ___VARIABLE_MODULE_NAME___PresenterRouterInterface &
                                 ___VARIABLE_MODULE_NAME___PresenterInteractorInterface &
                                 ___VARIABLE_MODULE_NAME___PresenterViewInterface {

    var router: ___VARIABLE_MODULE_NAME___RouterPresenterInterface? { get }
    var interactor: ___VARIABLE_MODULE_NAME___InteractorPresenterInterface? { get }
    var view: ___VARIABLE_MODULE_NAME___ViewPresenterInterface? { get }

}

// MARK: - view

protocol ___VARIABLE_MODULE_NAME___ViewPresenterInterface: ViewPresenterInterface {

}

protocol ___VARIABLE_MODULE_NAME___ViewInterface: ViewInterface &
                            ___VARIABLE_MODULE_NAME___ViewPresenterInterface {
    var presenter: ___VARIABLE_MODULE_NAME___PresenterViewInterface? { get }

}

// MARK: - module builder

final class ___VARIABLE_MODULE_NAME___Module: ModuleInterface {

    func build() -> UIViewController {
        let view = ___VARIABLE_MODULE_NAME___View()
        let interactor = ___VARIABLE_MODULE_NAME___Interactor()
        let presenter = ___VARIABLE_MODULE_NAME___Presenter()
        let router = ___VARIABLE_MODULE_NAME___Router()

        view.presenter = presenter

        presenter.interactor = interactor
        presenter.view = view
        presenter.router = router

        interactor.presenter = presenter

        router.presenter = presenter
        router.viewController = view

        return view
    }
}
