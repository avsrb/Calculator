//
//  ViewController.swift
//  Calculator
//
//  Created by Artem Serebriakov on 01.08.2022.
//

import UIKit

var buttonTypes: [[ButtonType]] {
    [
        [.allClear, .negative, .percent, .operation(.division)],
        [.digit(.seven), .digit(.eight), .digit(.nine), .operation(.multiplication)],
        [.digit(.four), .digit(.five), .digit(.six), .operation(.subtraction)],
        [.digit(.one), .digit(.two), .digit(.three), .operation(.addition)],
        [.digit(.zero), .decimal, .equals]]
}

var buttonZero = UIButton()

func getButtonSize() -> CGFloat {
    let screenWidth = UIScreen.main.bounds.width
    let buttonCount: CGFloat = 3
    let spacingCount = buttonCount + 1
    return (screenWidth - (spacingCount * Constants.spacing)) / buttonCount
}

class ViewController: UIViewController {
    var calculator = Calculator()
    var target: UIViewController!

    var displayText: String {
        return calculator.displayText
    }

    let verticalStackView: UIStackView = {
        let resultLabel: UILabel = {
            let resultLabel = UILabel()
            
            resultLabel.translatesAutoresizingMaskIntoConstraints = false
            resultLabel.text = "0"
            resultLabel.textAlignment = .right
            return resultLabel
        }()
        
        let verticalStackView = UIStackView()
        verticalStackView.translatesAutoresizingMaskIntoConstraints = false
        verticalStackView.distribution = .fillEqually
        verticalStackView.axis = .vertical
        verticalStackView.spacing = Constants.spacing
        
        verticalStackView.addArrangedSubview(resultLabel)
        
        for subArray in buttonTypes {
            let horizontalStackView = UIStackView()
            horizontalStackView.translatesAutoresizingMaskIntoConstraints = false
            horizontalStackView.distribution = .fillEqually
            horizontalStackView.axis = .horizontal
            horizontalStackView.spacing = Constants.spacing

            for element in subArray {
                let button = CalculatorButton()
                button.translatesAutoresizingMaskIntoConstraints = false
                button.backgroundColor = element.backgroundColor
                button.layer.cornerRadius = Constants.spacing
                button.setTitle(element.description, for: .normal)
                button.addTarget(target, action: #selector(buttonNumberOn), for: .touchUpInside)
                if element == .digit(.zero) {
                    buttonZero = button
                    horizontalStackView.distribution = .fillProportionally
                }
                horizontalStackView.addArrangedSubview(button)
            }
            verticalStackView.addArrangedSubview(horizontalStackView)
        }
        return verticalStackView
    }()
    
    
    @objc func buttonNumberOn(_ sender: UIButton) {
        print(sender.currentTitle!)
//        res += sender.currentTitle!
    }

    override func viewDidLoad() {
        view.addSubview(verticalStackView)
        print(getButtonSize())
        
        NSLayoutConstraint.activate([
            verticalStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
            verticalStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            verticalStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            verticalStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
            buttonZero.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.4)
            //buttonZero.widthAnchor.constraint(equalToConstant: getButtonSize()*2)
            //firstView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.673)
        ])
    }
    
//    override func updateViewConstraints() {
//
//        if UIWindow.isLandscape {
//            NSLayoutConstraint.activate([
//                verticalStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
//                verticalStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
//                verticalStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
//                verticalStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
//                buttonZero.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.4)
//                //buttonZero.widthAnchor.constraint(equalToConstant: getButtonSize()*2)
//                //firstView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.673)
//            ])
//        } else {
//            NSLayoutConstraint.activate([
//                verticalStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
//                verticalStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
//                verticalStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
//                verticalStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
//                buttonZero.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.4)
//                //buttonZero.widthAnchor.constraint(equalToConstant: getButtonSize()*2)
//                //firstView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.673)
//            ])
//        }
//        super.updateViewConstraints()
//    }
}

extension ViewController {
    
}
