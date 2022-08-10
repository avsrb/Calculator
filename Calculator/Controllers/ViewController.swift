//
//  ViewController.swift
//  Calculator
//
//  Created by Artem Serebriakov on 01.08.2022.
//

import UIKit

var buttonTypes: [[ButtonType]] {
    [
        [.allClear, .negative, .percent],
        [.digit(.seven), .digit(.eight), .digit(.nine)],
        [.digit(.four), .digit(.five), .digit(.six)],
        [.digit(.one), .digit(.two), .digit(.three)],
        [.digit(.zero)]]
}

var buttonOperation: [ButtonType] {
    [
        .operation(.division),
        .operation(.multiplication),
        .operation(.subtraction),
        .operation(.addition),
        .equals
    ]
}

var buttonZero = UIButton()

final class ViewController: UIViewController {
    var presenter: ViewToPresenterCalculatorProtocol?
    var target: UIViewController!
    var regularConstraints: [NSLayoutConstraint] = []
    var compactConstraints: [NSLayoutConstraint] = []
    var buttonZeroSize:[NSLayoutConstraint] = []

    let resultLabel: UILabel = {
        let resultLabel = UILabel()
        
        resultLabel.translatesAutoresizingMaskIntoConstraints = false
        resultLabel.font = .systemFont(ofSize: UIScreen.main.bounds.height / 10)
        resultLabel.text = "0"
        resultLabel.textAlignment = .right
        resultLabel.adjustsFontSizeToFitWidth = true
        return resultLabel
    }()

    let numberStackView: UIStackView = {
        
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
    
    let verticalStackViewOperation: UIStackView = {
        
        let verticalStackView = UIStackView()
        verticalStackView.distribution = .fillEqually
        verticalStackView.axis = .vertical
        verticalStackView.spacing = Constants.spacing
        verticalStackView.translatesAutoresizingMaskIntoConstraints = false
                
        for element in buttonOperation {
            let horizontalStackView = UIStackView()
            horizontalStackView.distribution = .fillEqually
            horizontalStackView.axis = .horizontal
            horizontalStackView.spacing = Constants.spacing
            horizontalStackView.translatesAutoresizingMaskIntoConstraints = false

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
            horizontalStackView.addArrangedSubview(button)
            
            verticalStackView.addArrangedSubview(horizontalStackView)
        }
        return verticalStackView
    }()
    
    let buttonPodStackView: UIStackView = {
        
        let buttonPodStackView = UIStackView()
        buttonPodStackView.distribution = .fill
        buttonPodStackView.axis = .horizontal
        buttonPodStackView.spacing = Constants.spacing
        buttonPodStackView.translatesAutoresizingMaskIntoConstraints = false
        return buttonPodStackView
    }()
    
    let finalStackView: UIStackView = {
        
        let finalStackView = UIStackView()
        finalStackView.distribution = .fill
        finalStackView.axis = .vertical
        finalStackView.spacing = Constants.spacing
        finalStackView.translatesAutoresizingMaskIntoConstraints = false
        return finalStackView
    }()
    
    
    
    @objc func buttonOn(_ sender: UIButton) {
        presenter?.performAction(sender.titleLabel?.text)
    }
    
    func getButtonSize() -> CGFloat {
        let screenWidth = self.view.bounds.size.width
        let buttonCount: CGFloat = 4
        let spacingCount = buttonCount + 1
        return (screenWidth - (spacingCount * Constants.spacing)) / buttonCount
    }
    
    override func loadView() {
        super.loadView()
        
        buttonPodStackView.addArrangedSubview(numberStackView)
        buttonPodStackView.addArrangedSubview(verticalStackViewOperation)
        finalStackView.addArrangedSubview(resultLabel)
        finalStackView.addArrangedSubview(buttonPodStackView)
        view.addSubview(finalStackView)
        
        self.regularConstraints = [
            resultLabel.heightAnchor.constraint(equalToConstant: getButtonSize()),
            finalStackView.heightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.75),
            finalStackView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            finalStackView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            finalStackView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            verticalStackViewOperation.widthAnchor.constraint(equalToConstant: getButtonSize())
        ]
        
        self.compactConstraints = [
            resultLabel.heightAnchor.constraint(equalToConstant: getButtonSize()),
            finalStackView.heightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.9),
            finalStackView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            finalStackView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            finalStackView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            verticalStackViewOperation.widthAnchor.constraint(equalToConstant: getButtonSize())
        ]
                
        self.activateCurrentConstraints()
    }
    
    override func viewWillLayoutSubviews() {
        print(#function)

    }
    

    private func activateCurrentConstraints() {
        NSLayoutConstraint.deactivate(self.compactConstraints + self.regularConstraints)

        if self.traitCollection.verticalSizeClass == .regular {
           NSLayoutConstraint.activate(self.regularConstraints)
        }
        else {
           NSLayoutConstraint.activate(self.compactConstraints)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
