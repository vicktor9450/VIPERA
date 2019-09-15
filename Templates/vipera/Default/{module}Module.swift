//
//  {module}Module.swift
//  {project}
//
//  Created by {author} on {date}.
//
import Foundation
import UIKit


// MARK: - router

protocol {module}RouterPresenterInterface: RouterPresenterInterface {

}

protocol {module}RouterInterface: RouterInterface &
                              {module}RouterPresenterInterface {
    var presenter: {module}PresenterRouterInterface! { get }

}

// MARK: - interactor

protocol {module}InteractorPresenterInterface: InteractorPresenterInterface {

}

protocol {module}InteractorInterface: InteractorInterface &
                                  {module}InteractorPresenterInterface {
    var presenter: {module}PresenterInteractorInterface! { get }

}

// MARK: - presenter

protocol {module}PresenterRouterInterface: PresenterRouterInterface {

}

protocol {module}PresenterInteractorInterface: PresenterInteractorInterface {

}

protocol {module}PresenterViewInterface: PresenterViewInterface {

}

protocol {module}PresenterInterface: PresenterInterface &
                                 {module}PresenterRouterInterface &
                                 {module}PresenterInteractorInterface &
                                 {module}PresenterViewInterface {

    var router: {module}RouterPresenterInterface! { get }
    var interactor: {module}InteractorPresenterInterface! { get }
    var view: {module}ViewPresenterInterface! { get }

}

// MARK: - view

protocol {module}ViewPresenterInterface: ViewPresenterInterface {

}

protocol {module}ViewInterface: ViewInterface &
                            {module}ViewPresenterInterface {
    var presenter: {module}PresenterViewInterface! { get }

}

// MARK: - module builder

final class {module}Module: ModuleInterface {

    func build() -> UIViewController {
        let view = {module}View()
        let interactor = {module}Interactor()
        let presenter = {module}Presenter()
        let router = {module}Router()

        view.presenter = presenter

        presenter.interactor = interactor
        presenter.view = view
        presenter.router = router

        interactor.presenter = presenter

        router.presenter = presenter

        return view
    }
}
