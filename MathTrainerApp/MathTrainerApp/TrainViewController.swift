//
//  TrainViewController.swift
//  MathTrainerApp
//
//  Created by Даниил Павленко on 01.04.2023.
//

import UIKit

final class TrainViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var rightButton: UIButton!
    @IBOutlet weak var questionLabel: UILabel!
    
    // MARK: - Properties
    private var firstNumber = 0
    private var secondNumber = 0
    private var sign: String = ""
    var count: Int = 0 {
        didSet {
            print("Count: \(count)")
        }
    }
    
    var type: MathTypes = .add {
        didSet{
            switch type {
            case .add:
                sign = "+"
            case .subtract:
                sign = "-"
            case .multiply:
                sign = "*"
            case .divide:
                sign = "/"
            }
        }
    }
    
    private var answer: Int {
        switch type {
        case .add:
            return firstNumber + secondNumber
        case .subtract:
            return firstNumber - secondNumber
        case .multiply:
            return firstNumber * secondNumber
        case .divide:
            return firstNumber / secondNumber
        }
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureQuestion()
        configurateButtonsTrainer()
    }
    
    // MARK: - IBActions
    @IBAction func leftAction(_ sender: UIButton) {
        check(answer: sender.titleLabel?.text ?? "", for: sender)
    }
    @IBAction func rightAction(_ sender: UIButton) {
        check(answer: sender.titleLabel?.text ?? "", for: sender)
    }
    
    // MARK: - Methods
    private func configurateButtonsTrainer() {
        [leftButton, rightButton].forEach { button in
            button?.backgroundColor = .systemYellow
        }
        
        // Add shadow
        [backButton, leftButton, rightButton].forEach { button in
            button.layer.shadowColor = UIColor.darkGray.cgColor
            button.layer.shadowOffset = CGSize(width: 0, height: 2)
            button.layer.shadowOpacity = 0.4
            button.layer.shadowRadius = 3
        }
        
        let isRightButton = Bool.random()
        var randomAnswer: Int
        repeat {
            randomAnswer = Int.random(in: (answer - 10)...(answer + 10))
        }
        while randomAnswer == answer
        
        rightButton.setTitle(isRightButton ? String(answer) : String(randomAnswer),
                             for: .normal)
        leftButton.setTitle(isRightButton ? String(randomAnswer) : String(answer),
                            for: .normal)
    }
    
    private func configureQuestion() {
        firstNumber = Int.random(in: 1...99)
        secondNumber = Int.random(in: 1...99)
        let question: String = "\(firstNumber) \(sign) \(secondNumber) ="
        questionLabel.text = question
    }
    
    private func check(answer: String, for button: UIButton) {
        let isRightAnswer = Int(answer) == self.answer
        
        button.backgroundColor = isRightAnswer ? .systemGreen : .systemRed
        
        if isRightAnswer {
            count += 1
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
                self?.configureQuestion()
                self?.configurateButtonsTrainer()
            }
        }
    }
}
