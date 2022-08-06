//
//  Digit.swift
//  Calculator
//
//  Created by Artem Serebriakov on 06.08.2022.
//

import Foundation

enum Digit: Int, CaseIterable, CustomStringConvertible {
    case zero, one, two, three, four, five, six, seven, eight, nine
    
    var description: String {
        "\(rawValue)"
    }
}
