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
   
    private var number: Int = 0
    private var newNumber: Int = 0
    private var result: Int?
    private var displayText: String = "0"
    private var currentOperation: ArithmeticOperation!
    enum Status {
        case waitForFirstOperand
        case typingFirstOperand
        case waitForSecondOperand
        case typingSecondOperand
        case didCalculation
    }
    var status: Status = .waitForFirstOperand

    private var rank: Int = 0

    // MARK: Init
    init(view: PresenterToViewCalculatorProtocol, router: PresenterToRouterCalculatorProtocol?) {
        self.view = view
        self.router = router
    }

    func performAction(_ buttonTitle: String?) {
        guard let buttonTitle = buttonTitle else {
            return
        }
        
        switch buttonTitle {
        case "0" ... "9":
            setDigit(buttonTitle)
        case ArithmeticOperation.addition.description, ArithmeticOperation.subtraction.description, ArithmeticOperation.multiplication.description, ArithmeticOperation.division.description:
            setOperation(buttonTitle)
        case ButtonType.negative.description:
            toggleSign()
        case ButtonType.equals.description :
            evaluate()
        case ButtonType.allClear.description :
            allClear()
        default:
            break
        }
    }

    func setDigit(_ digit: String) {
        if (status == .waitForFirstOperand ) {
            let digitInt = Int(digit)!
            number = number * 10 + digitInt
            view?.setDisplayText(String(number))
        } else if (status == .waitForSecondOperand) {
            let digitInt = Int(digit)!
            newNumber = newNumber * 10  + digitInt
            view?.setDisplayText(String(newNumber))
        }
    }

    func setOperation(_ operation: String) {
        status = .waitForSecondOperand
        if operation == "+" {
            currentOperation = .addition
        }
        else if operation == "-" {
            currentOperation = .subtraction
        }
        else if operation == "×" {
            currentOperation = .multiplication
        }
        else if operation == "÷" {
            currentOperation = .division
        }
    }
    func toggleSign() {
//        if let number = newNumber {
//            newNumber = -number
//            return
//        }
//        if let number = result {
//            result = -number
//            return
//        }
    }
    
    func evaluate() {
        switch currentOperation {
        case .addition:
            result = number + newNumber
        case .subtraction:
            result =  number - newNumber
        case .multiplication:
            result =  number * newNumber
        case .division:
            result =  number / newNumber
        default:
            break
        }
        view?.setDisplayText(String(result!))
    }

     func allClear() {
        number = 0
        newNumber = 0
        result = 0
        currentOperation = .none
        view?.setDisplayText(String(displayText))
     }
}

