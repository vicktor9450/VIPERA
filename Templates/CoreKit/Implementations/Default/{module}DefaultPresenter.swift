//
//  {module}DefaultPresenter.swift
//  {project}
//
//  Created by {author} on {date}.
//

import Foundation

class {module}DefaultPresenter {
    
    var router: {module}Router?
    var interactor: {module}Interactor?
    weak var view: {module}View?
}

extension {module}DefaultPresenter: {module}Presenter {
    
    func viewDidLoad() {
        self.view?.displayLoading()
        self.interactor?.loadData()
        .onSuccess(queue: .main) { data in
            self.view?.display(data)
        }
        .onFailure(queue: .main) { error in
            self.view?.display(error)
        }
    }
    
    func open() {
        self.router?.show()
    }

    func close() {
        self.router?.dismiss()
    }
}
