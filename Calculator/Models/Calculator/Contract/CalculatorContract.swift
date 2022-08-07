//
//  CalculatorContract.swift
//  Calculator
//
//  Created by Artem Serebriakov on 07.08.2022.
//

import Foundation

// MARK: View Output (Presenter -> View)
protocol PresenterToViewCalculatorProtocol: AnyObject {
    func setDisplayText(_ text: String)
    func clearInput()
    func getResult() -> Int?
    func bibError()
    func switchACButtonTitle(to title: String)
}

// MARK: View Input (View -> Presenter)
protocol ViewToPresenterCalculatorProtocol: AnyObject {
    func buttonDidTapped(_ buttonTitle: String?)
}

// MARK: Router Input (Presenter -> Router)
protocol PresenterToRouterCalculatorProtocol: AnyObject {}
