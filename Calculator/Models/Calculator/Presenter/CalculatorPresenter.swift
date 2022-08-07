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


    // MARK: Init

    init(view: PresenterToViewCalculatorProtocol, router: PresenterToRouterCalculatorProtocol?) {
        self.view = view
        self.router = router
    }

    func buttonDidTapped(_ buttonTitle: String?) {
        guard let buttonTitle = buttonTitle else {
            return
        }
        
        switch buttonTitle {
        case "0" ... "9":
            handleDigit(digit: buttonTitle)
        case ArithmeticOperation.addition.description, ArithmeticOperation.subtraction.description, ArithmeticOperation.multiplication.description, ArithmeticOperation.division.description:
            handleOperations(operationCharecter: buttonTitle)
        case ButtonType.negative.description:
            toggleSign()
        case ButtonType.equals.description :
            pushResult(result: 0.1)
        case ButtonType.allClear.description :
            view?.setDisplayText("0")
        default:
            return
        }
    }

    private func handleDigit(digit: String) {
        let digitInt = Int(digit) ?? 0
//        currValue = rank < 15 ? currValue * 10 + digitInt : currValue
//        rank += 1
//        if rank > 15 { rank = 15 }
//        view?.setDisplayText(String(currValue))
    }


    private func handleOperations(operationCharecter: String) {
        
    }

    private func toggleSign() {
       
    }

    private func pushResult(result: Double) {
       
    }
}
