//
//  {module}Presenter.swift
//  {project}
//
//  Created by {author} on {date}.
//

import Foundation

protocol {module}Presenter: class {
    
    var router: {module}Router? { get set }
    var interactor: {module}Interactor? { get set }
    var view: {module}View? { get set }
    
    func viewDidLoad()
    func open()
    func close()
}
