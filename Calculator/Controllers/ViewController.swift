//
//  ViewController.swift
//  Calculator
//
//  Created by Artem Serebriakov on 01.08.2022.
//

import UIKit

class ViewController: UIViewController {
    
    let buttonNames = [
        ["AC", "+⁄−", " ", "÷"],
        ["7", "8", "9", "×"],
        ["4", "5", "6", "-"],
        ["1", "2", "3", "+"],
        ["0", " ", " ", "="],
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .red
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        
        let hStack0 = UIStackView()
        
        hStack0.translatesAutoresizingMaskIntoConstraints = false
        hStack0.distribution = .fillEqually
        hStack0.axis = .horizontal
        hStack0.spacing = 5
        
    
        let button1 = CalulatorButton()
        button1.setTitle("1", for: .normal)
        let button2 = CalulatorButton()
        button2.setTitle("2", for: .normal)
        let button3 = CalulatorButton()
        button3.setTitle("3", for: .normal)
        
//        hStack0.addArrangedSubview(button1)
//        hStack0.addArrangedSubview(button2)
//        hStack0.addArrangedSubview(button3)
        
        let hStack1 = UIStackView()
        
        hStack1.translatesAutoresizingMaskIntoConstraints = false
        hStack1.distribution = .fillEqually
        hStack1.axis = .horizontal
        hStack1.spacing = 5
    
        let button4 = CalulatorButton()
        button4.setTitle("4", for: .normal)
        let button5 = CalulatorButton()
        button5.setTitle("5", for: .normal)
        let button6 = CalulatorButton()
        button6.setTitle("6", for: .normal)
        
//        hStack1.addArrangedSubview(button4)
//        hStack1.addArrangedSubview(button5)
//        hStack1.addArrangedSubview(button6)

        let hStack2 = UIStackView()
        //let hStack2 = UIStackView(frame: CGRect(x: 0, y: view.frame.height - (view.frame.width/4)*3, width: view.frame.width/4*3, height: view.frame.width/4))
        
        hStack2.translatesAutoresizingMaskIntoConstraints = false
        hStack2.distribution = .fillEqually
        hStack2.axis = .horizontal
        hStack2.spacing = 5
    
        let button7 = CalulatorButton()
        button7.setTitle("7", for: .normal)
        let button8 = CalulatorButton()
        button8.setTitle("8", for: .normal)
        let button9 = CalulatorButton()
        button9.setTitle("9", for: .normal)
        
//        hStack2.addArrangedSubview(button7)
//        hStack2.addArrangedSubview(button8)
//        hStack2.addArrangedSubview(button9)
        
        
        
        
        
        let vStack = UIStackView()
//        vStack.translatesAutoresizingMaskIntoConstraints = false
        vStack.backgroundColor = .white
        vStack.distribution = .fillEqually
        vStack.axis = .vertical
        vStack.spacing = 5
        
        vStack.addArrangedSubview(hStack0)
        vStack.addArrangedSubview(hStack1)
        vStack.addArrangedSubview(hStack2)
        vStack.translatesAutoresizingMaskIntoConstraints = false
//        vStack.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.9).isActive = true
//        vStack.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9).isActive = true
//        vStack.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        vStack.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true

        view.addSubview(vStack)
        

        
    }
    
}

class CalulatorButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        titleLabel?.font = .systemFont(ofSize: super.frame.width/3)
        setTitleColor(.white, for: .normal)
        backgroundColor = .darkGray
        clipsToBounds = true
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = bounds.size.width / 2
    }
}
