//
//  CalculatorAssembly.swift
//  Calculator
//
//  Created by Artem Serebriakov on 07.08.2022.
//

import UIKit

enum CalculatorAssembly {
    // MARK: Static methods

    static func createModule() -> UIViewController {
        let viewController = ViewController()
        let router = CalculatorRouter(view: viewController)
        let presenter = CalculatorPresenter(view: viewController, router: router)

        viewController.presenter = presenter

        return viewController
    }
}
