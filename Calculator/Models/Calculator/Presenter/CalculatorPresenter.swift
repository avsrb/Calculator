//
//  CalculatorPresenter.swift
//  Calculator
//
//  Created by Artem Serebriakov on 07.08.2022.
//

import Foundation

class CalculatorPresenter: ViewToPresenterCalculatorProtocol {
    // MARK: Properties
    weak var view: PresenterToViewCalculatorProtocol?
    let router: PresenterToRouterCalculatorProtocol?

    var output: String = "0"
    var result: Int = 0
    var operand: Int?
    var operation: String?
    var didCalculation: Bool = false
    var historyText: String = ""
    enum Status {
        case waitForFirstOperand
        case typingFirstOperand
        case waitForSecondOperand
        case typingSecondOperand
        case didCalculation
    }

    var status: Status = .waitForFirstOperand

    // MARK: Init

    init(view: PresenterToViewCalculatorProtocol, router: PresenterToRouterCalculatorProtocol?) {
        self.view = view
        self.router = router
    }

    func buttonDidTapped(_ buttonTitle: String?) {
        guard let buttonTitle = buttonTitle else {
            return
        }
    }

    private func handleDigit(digit: String) {

    }

    private func handleResult() {
       
    }

    private func handleOperations(operationCharecter: String) {
       
    }

    private func calculate(result: Double, operation: String, operand: Double) -> Double? {
        switch operation {
        case "+":
            return (result + operand)
        case "-":
            return (result - operand)
        case "*", "×":
            return (result * operand)
        case "/", "÷":
            return (result / operand)
        default:
            return nil
        }
    }

    private func handlePlusMinus() {
       
    }

    private func pushResult(result: Double) {
       
    }
}
