//
//  {module}View.swift
//  {project}
//
//  Created by {author} on {date}.
//

import Foundation
import UIKit

final class {module}View: UIViewController, ViewInterface {

    var presenter: {module}PresenterViewInterface!


    func viewDidLoad() {
        super.viewDidLoad()

        self.presenter.ready()
    }

}

extension {module}View: {module}ViewPresenterInterface {

}