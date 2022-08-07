//
//  CalculatorRouter.swift
//  Calculator
//
//  Created by Artem Serebriakov on 07.08.2022.
//

import UIKit

class CalculatorRouter: PresenterToRouterCalculatorProtocol {
    // MARK: - Properties

    weak var view: UIViewController?

    // MARK: - Init

    init(view: UIViewController) {
        self.view = view
    }
}
