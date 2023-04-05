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
    @IBOutlet weak var leftButtonAnswer: UIButton!
    @IBOutlet weak var rightButtonAnswer: UIButton!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var correctAnswers: UILabel!
    
    // MARK: - Properties
    private var firstNumber = 0
    private var secondNumber = 0
    private var sign: String = ""
    
    public var correctAnswerCount: Int = 0 {
        didSet {
            print("Count: \(correctAnswerCount)")
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
        addShadow()
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
        let defaultColor: UIColor = .systemYellow
        leftButtonAnswer.backgroundColor = defaultColor
        rightButtonAnswer.backgroundColor = defaultColor
        
        let isRightButton = Bool.random()
        var randomAnswer: Int
        repeat {
            randomAnswer = Int.random(in: (answer - 10)...(answer + 10))
        } while randomAnswer == answer
        
        rightButtonAnswer.setTitle(isRightButton ? String(answer) : String(randomAnswer),
                             for: .normal)
        leftButtonAnswer.setTitle(isRightButton ? String(randomAnswer) : String(answer),
                            for: .normal)
    }
    
    private func addShadow() {
        [backButton, leftButtonAnswer, rightButtonAnswer].forEach { button in
            button.layer.shadowColor = UIColor.darkGray.cgColor
            button.layer.shadowOffset = CGSize(width: 0, height: 2)
            button.layer.shadowOpacity = 0.4
            button.layer.shadowRadius = 3
        }
    }
    
    private func configureQuestion() {
        switch type {
        case .add, .subtract, .multiply:
            firstNumber = Int.random(in: 1...99)
            secondNumber = Int.random(in: 1...99)
        case .divide:
            repeat {
                firstNumber = Int.random(in: 1...99)
                secondNumber = Int.random(in: 1...99)
            } while firstNumber % secondNumber != 0
        }
        
        let question: String = "\(firstNumber) \(sign) \(secondNumber) ="
        questionLabel.text = question
    }

    private func check(answer: String,  for button: UIButton) {
        let isRightAnswer = Int(answer) == self.answer
        button.backgroundColor = isRightAnswer ? .systemGreen : .systemRed
        leftButtonAnswer.isEnabled = false
        rightButtonAnswer.isEnabled = false
        if isRightAnswer {
            correctAnswerCount += 1
            showCorrectAnswerCount()
        }
        DispatchQueue.main.asyncAfter(deadline:.now() + 1) { [weak self] in
            self?.leftButtonAnswer.isEnabled = true
            self?.rightButtonAnswer.isEnabled = true
            self?.configureQuestion()
            self?.configurateButtonsTrainer()
        }
    }
    
    private func showCorrectAnswerCount() {
        correctAnswers.text = "Верных ответов :\n\(correctAnswerCount)"
    }
}
