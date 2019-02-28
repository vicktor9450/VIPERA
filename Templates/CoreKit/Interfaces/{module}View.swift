//
//  {module}View.swift
//  {project}
//
//  Created by {author} on {date}.
//

import Foundation

protocol {module}View: class {
    
    var presenter: {module}Presenter? { get set }

    func displayLoading()
    func display(_ error: Error)
    func display(_ data: Any)
}
