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
    var presenter: ViewToPresenterCalculatorProtocol?
    var target: UIViewController!
    
    let resultLabel: UILabel = {
        let resultLabel = UILabel()
        
        resultLabel.translatesAutoresizingMaskIntoConstraints = false
        resultLabel.font = .systemFont(ofSize: UIScreen.main.bounds.width > UIScreen.main.bounds.height ? UIScreen.main.bounds.height / 7 : UIScreen.main.bounds.width / 7)
        resultLabel.text = "13"
        resultLabel.textAlignment = .right
        return resultLabel
    }()

    let verticalStackView: UIStackView = {
        
        let verticalStackView = UIStackView()
        verticalStackView.translatesAutoresizingMaskIntoConstraints = false
        verticalStackView.distribution = .fillEqually
        verticalStackView.axis = .vertical
        verticalStackView.spacing = Constants.spacing
                
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
                button.addTarget(target, action: #selector(buttonOn), for: .touchUpInside)
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
    
    @objc func buttonOn(_ sender: UIButton) {
        presenter?.buttonDidTapped(sender.titleLabel?.text)
    }
    
    override func viewDidLoad() {
        verticalStackView.insertArrangedSubview(resultLabel, at: 0)
        view.addSubview(verticalStackView)
        print(getButtonSize())
        
        NSLayoutConstraint.activate([
            verticalStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
            verticalStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            verticalStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            verticalStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
            buttonZero.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.4)
            //buttonZero.widthAnchor.constraint(equalToConstant: getButtonSize()*2)
        ])
    }
}

extension ViewController: PresenterToViewCalculatorProtocol {
    func setDisplayText(_ text: String) {
        resultLabel.text! += text
    }
    
    func clearInput() {
        resultLabel.text = "0"
    }
    
    func getResult() -> Int? {
        Int(resultLabel.text ?? "")
    }
    
    func bibError() {
        return
    }
    
    func switchACButtonTitle(to title: String) {
        return
    }
    

}
