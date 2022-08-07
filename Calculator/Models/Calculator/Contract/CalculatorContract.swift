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
    func setOperation(_ operation: String)
    func toggleSign()
    func setDecimal(_ digit: Digit)
    func evaluate()
    func allClear()
}

// MARK: View Input (View -> Presenter)
protocol ViewToPresenterCalculatorProtocol: AnyObject {
    func performAction(_ buttonTitle: String?)
}

// MARK: Router Input (Presenter -> Router)
protocol PresenterToRouterCalculatorProtocol: AnyObject {}
