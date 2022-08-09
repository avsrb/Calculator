//
//  ArithmeticOperation.swift
//  Calculator
//
//  Created by Artem Serebriakov on 06.08.2022.
//

import Foundation

enum ArithmeticOperation: CaseIterable, CustomStringConvertible {
    case addition, subtraction, multiplication, division, empty
    
    var description: String {
        switch self {
        case .addition:
            return "+"
        case .subtraction:
            return "−"
        case .multiplication:
            return "×"
        case .division:
            return "÷"
        case .empty:
            return ""
        }
    }
}
