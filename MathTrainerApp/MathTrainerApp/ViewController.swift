//
//  ViewController.swift
//  MathTrainerApp
//
//  Created by Даниил Павленко on 01.04.2023.
//

import UIKit

enum MathTypes: Int {
    case add, subtract, multiply, divide
}

class ViewController: UIViewController {
    // MARK: - IBOutlet
    @IBOutlet var buttonsCollection: [UIButton]!
    @IBOutlet weak var addLabel: UILabel!
    @IBOutlet weak var subtractLabel: UILabel!
    @IBOutlet weak var multiplyLabel: UILabel!
    @IBOutlet weak var divideLabel: UILabel!
    
    // MARK: - Properties
    private var selectedType: MathTypes = .add
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configurateButtons()
    }
    
    // MARK: - IBAction
    @IBAction func buttonsAction(_ sender: UIButton) {
        selectedType = MathTypes(rawValue: sender.tag) ?? .add
        performSegue(withIdentifier: "goToNext", sender: sender)
    }
    
    @IBAction func unwindAction(unwindSegue: UIStoryboardSegue) {
        if let source = unwindSegue.source as? TrainViewController {
            switch source.type {
            case .add: addLabel.text = String(source.correctAnswerCount)
            case .subtract: subtractLabel.text = String(source.correctAnswerCount)
            case .multiply: multiplyLabel.text = String(source.correctAnswerCount)
            case .divide: divideLabel.text = String(source.correctAnswerCount)
            }
        }
    }
    
    // MARK: - Methods
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewController = segue.destination as? TrainViewController {
            viewController.type = selectedType
        }
    }
    
    private func configurateButtons() {
        // Add shadow
        buttonsCollection.forEach { button in
            button.layer.shadowColor = UIColor.darkGray.cgColor
            button.layer.shadowOffset = CGSize(width: 0, height: 2)
            button.layer.shadowOpacity = 0.4
            button.layer.shadowRadius = 3
        }
    }
}
