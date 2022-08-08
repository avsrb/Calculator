//
//  CalculatorButton.swift
//  Calculator
//
//  Created by Artem Serebriakov on 06.08.2022.
//

import UIKit

class CalculatorButton: UIButton {
    
    var isWide = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        titleLabel?.font = .systemFont(ofSize: UIScreen.main.bounds.width > UIScreen.main.bounds.height ? UIScreen.main.bounds.height / 10 : UIScreen.main.bounds.width / 10)
        setTitleColor(.white, for: .normal)
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override var isHighlighted: Bool {
        didSet {
            backgroundColor = isHighlighted ? .white : .darkGray
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if UIWindow.isLandscape {
            layer.cornerRadius = bounds.size.width < UIScreen.main.bounds.width/2 ? bounds.size.width / 7 : bounds.size.width / 23
        } else {
            layer.cornerRadius = bounds.size.width < UIScreen.main.bounds.width/2 ? bounds.size.width / 2 : bounds.size.width / 6.5
        }
    }
}

class ArithmeticOperationButton : CalculatorButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override var isHighlighted: Bool {
        didSet {
            backgroundColor = isHighlighted ? .white : .orange
        }
    }
}

class OperationButton : CalculatorButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override var isHighlighted: Bool {
        didSet {
            backgroundColor = isHighlighted ? .white : .lightGray
        }
    }
}
