//
//  {module}DefaultView.swift
//  {project}
//
//  Created by {author} on {date}.
//

import Foundation
import UIKit

class {module}DefaultView: UIViewController {
    
    var presenter: {module}Presenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        self.presenter?.viewDidLoad()
    }

    @objc func open() {
        self.presenter?.open()
    }

    @objc func close() {
        self.presenter?.close()
    }
}

extension {module}DefaultView: {module}View {

    func displayLoading() {
        
    }
    
    func display(_ error: Error) {
        
    }
    
    func display(_ data: Any) {
        
    }
}
