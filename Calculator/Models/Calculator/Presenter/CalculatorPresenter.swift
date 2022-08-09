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
    private var currentOperation: ArithmeticOperation = .empty
    private var error = false
    
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
        print("isOperation  \(isOperation)")
        print("number       \(number)")
        print("numberNew    \(numberNew)")
        print("result       \(result)")
        print("Operation \(currentOperation)")
        print()

    }

    func setDigit(_ digit: String) {
        guard let digit = Int(digit) else {
            return
        }
        if isOperation {
            numberNew = rank < 12 ? numberNew * 10 + digit : numberNew
            view?.setDisplayText(String(numberNew))
        } else {
            number = rank < 12 ? number * 10 + digit : number
            view?.setDisplayText(String(number))
        }
        rank += 1
        
    }

    func setOperation(_ operation: String) {
        rank = 0
        if isOperation {
            evaluate()
        }
        isOperation = true
        if operation == ArithmeticOperation.addition.description {
            currentOperation = .addition
        }
        else if operation == ArithmeticOperation.subtraction.description {
            currentOperation = .subtraction
        }
        else if operation == ArithmeticOperation.multiplication.description {
            currentOperation = .multiplication
        }
        else if operation == ArithmeticOperation.division.description {
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
                result = number &+ numberNew
            case .subtraction:
                result = number &- numberNew
            case .multiplication:
                result = number &* numberNew
            case .division:
            if (numberNew == 0) {
                view?.setDisplayText("Error")
                return
            } else {
                result = number & numberNew
            }
            default:
                break
        }
        if (result < Int32.min || result > Int32.max) {
            isOperation = false
            numberNew = 0
            number = 0
            result = 0
            rank = 0
            currentOperation = .empty
            view?.setDisplayText(String("Error"))
            return
        }
        isOperation = false
        currentOperation = .empty
        number = result
        numberNew = 0
        rank = String(result).count
        view?.setDisplayText(String(result))
    }

    func allClear() {
        rank = 0
        isOperation = false
        numberNew = 0
        number = 0
        result = 0
        currentOperation = .empty
        view?.setDisplayText(String("0"))
    }
    
}

