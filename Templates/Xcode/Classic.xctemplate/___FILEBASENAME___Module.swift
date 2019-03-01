//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created ___FULLUSERNAME___ on ___DATE___.
//  Copyright © ___YEAR___ ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation
import UIKit

class ___VARIABLE_MODULE_NAME___Module {

    func buildDefault() -> UIViewController {
        let view = ___VARIABLE_MODULE_NAME___DefaultView()
        let interactor = ___VARIABLE_MODULE_NAME___DefaultInteractor()
        let presenter = ___VARIABLE_MODULE_NAME___DefaultPresenter()
        let router = ___VARIABLE_MODULE_NAME___DefaultRouter()

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
