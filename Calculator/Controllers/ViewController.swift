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
        [.digit(.zero), .equals]]
}

var buttonZero = UIButton()

class ViewController: UIViewController {
    var presenter: ViewToPresenterCalculatorProtocol?
    var target: UIViewController!
    var regularConstraints: [NSLayoutConstraint] = []
    var compactConstraints: [NSLayoutConstraint] = []

    let resultLabel: UILabel = {
        let resultLabel = UILabel()
        
        resultLabel.translatesAutoresizingMaskIntoConstraints = false
        resultLabel.font = .systemFont(ofSize: UIScreen.main.bounds.height / 18)
        resultLabel.text = "0"
        resultLabel.textAlignment = .right
        return resultLabel
    }()

    let verticalStackView: UIStackView = {
        
        let verticalStackView = UIStackView()
        verticalStackView.distribution = .fillEqually
        verticalStackView.axis = .vertical
        verticalStackView.spacing = Constants.spacing
        verticalStackView.translatesAutoresizingMaskIntoConstraints = false
                
        for subArray in buttonTypes {
            let horizontalStackView = UIStackView()
            horizontalStackView.distribution = .fillEqually
            horizontalStackView.axis = .horizontal
            horizontalStackView.spacing = Constants.spacing
            horizontalStackView.translatesAutoresizingMaskIntoConstraints = false

            for element in subArray {
                var button: UIButton!
                switch element {
                case .digit( _):
                    button = CalculatorButton()
                case .operation( _), .equals:
                    button = ArithmeticOperationButton()
                default :
                    button = OperationButton()
                }
                
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
        presenter?.performAction(sender.titleLabel?.text)
    }
    
    func getButtonSize() -> CGFloat {
        let screenWidth = verticalStackView.bounds.width
        let buttonCount: CGFloat = 4
        let spacingCount = buttonCount + 1
        return (screenWidth - (spacingCount * Constants.spacing)) / buttonCount
    }
    
    override func viewDidLoad() {

    }
    
    
    override func loadView() {
        super.loadView()
        
        verticalStackView.insertArrangedSubview(resultLabel, at: 0)
        view.addSubview(verticalStackView)
        buttonZero.translatesAutoresizingMaskIntoConstraints = false

        
        self.regularConstraints = [
            verticalStackView.heightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.8),
            verticalStackView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            verticalStackView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            verticalStackView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            buttonZero.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 65.5/100)
        ]
        
        self.compactConstraints = [
            verticalStackView.heightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.heightAnchor, constant: 20),
            verticalStackView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            verticalStackView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            verticalStackView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            buttonZero.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 62/100)
        ]
        
        self.activateCurrentConstraints()
        
    }

    private func activateCurrentConstraints() {
        NSLayoutConstraint.deactivate(self.compactConstraints + self.regularConstraints)

        if view.frame.width < view.frame.height {
            NSLayoutConstraint.activate(self.regularConstraints)
        }
        else {
            NSLayoutConstraint.activate(self.compactConstraints)
        }
    }
    // MARK: - rotation support

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .allButUpsideDown
    }

    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        return .portrait
    }
    
    // MARK: - trait collections

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        self.activateCurrentConstraints()
    }
}

extension ViewController: PresenterToViewCalculatorProtocol {
    func setOperation(_ operation: String) {
        return
    }
    
    func toggleSign() {
        return
    }
    
    func setDecimal(_ digit: Digit) {
        return
    }
    
    func evaluate() {
        return
    }
    
    func allClear() {
        return
    }
    
    func setDisplayText(_ text: String) {
        resultLabel.text = text
    }
    
    func clear() {
        resultLabel.text = "0"
    }

}
