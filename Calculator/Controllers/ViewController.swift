//
//  ViewController.swift
//  Calculator
//
//  Created by Artem Serebriakov on 01.08.2022.
//

import UIKit

let mainBackgroundColor = UIColor.black
var input = String()
private var mask = "XXX XXX XXX XXX XXX XXX XXX"
private let maskNegativ = "- XXX XXX XXX XXX XXX XXX XXX"
private let replacementCharacter: Character = "X"


class ViewController: UIViewController {
    
    lazy var gap = view.frame.height / 50
    
    private let resultLabel: UILabel = {
        let lable = UILabel()
        lable.text = "0"
        lable.textColor = UIColor.white
        lable.textAlignment = .right
        lable.font = UIFont(name: "Helvetica", size: 40)
        lable.adjustsFontSizeToFitWidth = true
        return lable
    }()
    
    private let verticalStackView: UIStackView = {
        let verticalStackView = UIStackView()
        verticalStackView.distribution = .fillEqually
        verticalStackView.axis = .vertical
        verticalStackView.spacing = 10
        verticalStackView.translatesAutoresizingMaskIntoConstraints = false
        return verticalStackView
    }()
    
    lazy var horizontalStackviewButton0: UIStackView = {
        let stackView = createHorizontalStackview(buttonNames[0])
        return stackView
    }()
    
    lazy var horizontalStackviewButton1: UIStackView = {
        let stackView = createHorizontalStackview(buttonNames[1])
        return stackView
    }()
    
    lazy var horizontalStackviewButton2: UIStackView = {
        let stackView = createHorizontalStackview(buttonNames[2])
        return stackView
    }()
    
    lazy var horizontalStackviewButton3: UIStackView = {
        let stackView = createHorizontalStackview(buttonNames[3])
        return stackView
    }()
    
    lazy var horizontalStackviewButton4: UIStackView = {
        let stackView = createHorizontalStackview(buttonNames[4])
        return stackView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = mainBackgroundColor
        
        horizontalStackviewButton4.distribution = .fillProportionally
        let firstView = horizontalStackviewButton4.arrangedSubviews[0]
        
        verticalStackView.addArrangedSubview(resultLabel)
        verticalStackView.addArrangedSubview(horizontalStackviewButton0)
        verticalStackView.addArrangedSubview(horizontalStackviewButton1)
        verticalStackView.addArrangedSubview(horizontalStackviewButton2)
        verticalStackView.addArrangedSubview(horizontalStackviewButton3)
        verticalStackView.addArrangedSubview(horizontalStackviewButton4)
        
        verticalStackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(verticalStackView)
        
        if UIWindow.isLandscape {
            NSLayoutConstraint.activate([
                verticalStackView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1.4),
                verticalStackView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
                verticalStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                //            verticalStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                verticalStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
                firstView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.673)
            ])
        } else {
            NSLayoutConstraint.activate([
                verticalStackView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.9),
                verticalStackView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
                verticalStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                //            verticalStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                verticalStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
                firstView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.673)
            ])
        }
}

    
    override func viewDidLayoutSubviews() {
    }
    
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
    }
}

class CalulatorButton: UIButton {
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

    override func layoutSubviews() {
        super.layoutSubviews()
        if UIWindow.isLandscape {
            layer.cornerRadius = bounds.size.width < UIScreen.main.bounds.width/2 ? bounds.size.width / 7 : bounds.size.width / 23
        } else {
            layer.cornerRadius = bounds.size.width < UIScreen.main.bounds.width/2 ? bounds.size.width / 2 : bounds.size.width / 6.5
        }
    }
}
    
let buttonNames = [
    ["AC", "+⁄−", " ", "÷"],
    ["7", "8", "9", "×"],
    ["4", "5", "6", "-"],
    ["1", "2", "3", "+"],
    ["0",  "="],
]

extension ViewController {

    func createHorizontalStackview(_ nameButtons: [String]) -> UIStackView {
        let stackView = UIStackView()
        let decimalCharacters = CharacterSet.decimalDigits
        
        stackView.distribution = .fillEqually
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        for nameButton in nameButtons {
            let button = CalulatorButton()
            button.setTitle(nameButton, for: .normal)
            button.backgroundColor = (nameButton.rangeOfCharacter(from: decimalCharacters) == nil) ? .systemOrange : .darkGray
            if nameButton.rangeOfCharacter(from: decimalCharacters) != nil {
                button.addTarget(self, action: #selector(buttonNumberPressed), for: .touchUpInside)
            }
            else {
                button.addTarget(self, action: #selector(buttonOperationPressed), for: .touchUpInside)
            }
            stackView.addArrangedSubview(button)
        }
        
        return stackView
    }

    @objc func buttonNumberPressed(_ sender: UIButton) {
        print(sender.currentTitle!)
        input += sender.currentTitle!
        resultLabel.text = input.applyPatternOnNumbers(pattern: mask, replacementCharacter: replacementCharacter)
    }
    
    @objc func buttonOperationPressed(_ sender: UIButton) {
        print("buttonOperationPressed \(sender.currentTitle!)")
        input += sender.currentTitle!
    }

}

extension String {
    func applyPatternOnNumbers(pattern: String, replacementCharacter: Character) -> String {
        var pureNumber = self.replacingOccurrences( of: "[^0-9]", with: "", options: .regularExpression)
        for index in 0 ..< pattern.count {
            guard index < pureNumber.count else { return pureNumber }
            let stringIndex = String.Index(utf16Offset: index, in: pattern)
            let patternCharacter = pattern[stringIndex]
            guard patternCharacter != replacementCharacter else { continue }
            pureNumber.insert(patternCharacter, at: stringIndex)
        }
        return pureNumber
    }
}
