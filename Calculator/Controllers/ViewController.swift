//
//  ViewController.swift
//  Calculator
//
//  Created by Artem Serebriakov on 01.08.2022.
//

import UIKit


class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .red
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let sizeButton = view.frame.size.width / 4
        createStackView(nameButtons: ["1", "2", "3"], StackViewFrame: CGRect(x: 0,
                                                                             y: view.frame.size.height - sizeButton,
                                                                             width: sizeButton * 3,
                                                                             height: sizeButton))
        createStackView(nameButtons: ["4", "5", "6"], StackViewFrame: CGRect(x: 0,
                                                                             y: view.frame.size.height - (sizeButton*2),
                                                                             width: sizeButton * 3,
                                                                             height: sizeButton))
        createStackView(nameButtons: ["7", "8", "9"], StackViewFrame: CGRect(x: 0,
                                                                             y: view.frame.size.height - (sizeButton*3),
                                                                             width: sizeButton * 3,
                                                                             height: sizeButton))
        
    }
    
    private func createButton(titles: [String]) -> [UIButton] {
        var buttons:[UIButton] = []
        let sizeButton = view.frame.size.width / 4
        
        for title in titles {
            let button = UIButton(frame: CGRect(x: 0,
                                         y: view.frame.size.height - (sizeButton*3),
                                         width: sizeButton * 3,
                                         height: sizeButton))
            button.setTitleColor(.black, for: .normal)
            button.backgroundColor = .white
            button.translatesAutoresizingMaskIntoConstraints = false
            button.setTitle(title, for: .normal)
            buttons.append(button)
        }
        return buttons
    }
    
    private func createStackView(nameButtons: [String], StackViewFrame: CGRect) {
        let hStackView = UIStackView(frame: StackViewFrame)
        hStackView.alignment = .fill
        hStackView.distribution = .fillEqually
        hStackView.spacing = 8.0

        let buttons = createButton(titles: nameButtons)
        for button in buttons {
            hStackView.addArrangedSubview(button)
        }
        view.addSubview(hStackView)
    }
 
}

extension ViewController {
    private func setupNumberPad() {
        let buttonSizeWidth = view.frame.size.width / 4
        
        let buttonZero = UIButton(frame: CGRect(x: 0, y: view.frame.size.height - buttonSizeWidth, width: buttonSizeWidth * 3, height: buttonSizeWidth))
        buttonZero.setTitleColor(.black, for: .normal)
        buttonZero.backgroundColor = .gray
        buttonZero.layer.cornerRadius = 50
        buttonZero.setTitle("0", for: .normal)
        view.addSubview(buttonZero)
        
        
        let buttonSizeHeidth = buttonSizeWidth
        let buttonLocationX = buttonSizeWidth
        let buttonLocationY = view.frame.size.height - buttonSizeHeidth
        var x: CGFloat = 0
        var y: CGFloat = buttonLocationY - buttonSizeHeidth
        
        var buttons: [UIButton] = []
        for i in 1...9 {
            let button = UIButton(frame: CGRect(x: x,
                                                y: y,
                                                width: buttonSizeWidth,
                                                height: buttonSizeHeidth))
            button.setTitleColor(.black, for: .normal)
            button.backgroundColor = .link
            button.layer.cornerRadius = 50
            button.setTitle(String(i), for: .normal)
            buttons.append(button)
            x += buttonLocationX
            
            if i == 3 || i == 6 {
                x = 0
                y -= buttonSizeHeidth
            }
        }
        for button in buttons {
            view.addSubview(button)
        }
    }
}

