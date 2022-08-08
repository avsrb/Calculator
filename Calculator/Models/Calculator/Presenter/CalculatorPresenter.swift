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
    private var numberNew: Int = 0
    private var result: Int = 0
    private var displayText: String = "0"
    private var rank: Int = 0
    private var currentOperation: ArithmeticOperation!
    
    var isOperation = false


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
        guard let digit = Int(digit) else {
            return
        }
        if isOperation {
            numberNew = numberNew * 10 + digit
            view?.setDisplayText(String(numberNew))
        } else {
            number = number * 10 + digit
            view?.setDisplayText(String(number))
        }
        
    }

    func setOperation(_ operation: String) {
        if isOperation {
            evaluate()
        }
//        } else {
            isOperation = true
//        }
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
        number = -number
        view?.setDisplayText(String(number))
    }
    
    func evaluate() {
        switch currentOperation {
            case .addition:
                result = number + numberNew
            case .subtraction:
                result = number - numberNew
            case .multiplication:
                result = number * numberNew
            case .division:
            if (numberNew == 0) {
                view?.setDisplayText("Error")
                return
            } else {
                result = number / numberNew
            }
            default:
                break
        }
        isOperation = false
        currentOperation = .none
        number = result
        numberNew = 0
        view?.setDisplayText(String(result))
    }

    func allClear() {
        isOperation = false
        numberNew = 0
        number = 0
        result = 0
        currentOperation = .none
        view?.setDisplayText(String("0"))
    }
    
}

