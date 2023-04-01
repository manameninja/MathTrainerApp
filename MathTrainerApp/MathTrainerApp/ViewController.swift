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
    @IBOutlet var buttonsColection: [UIButton]!
    
    // MARK: Properties
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
    
    @IBAction func unwindAction(unwindSegue: UIStoryboardSegue) { }
    
    // MARK: - Methods
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewController = segue.destination as? TrainViewController {
            viewController.type = selectedType
        }
    }
    
    private func configurateButtons() {
        // Add shadow
        buttonsColection.forEach { button in
            button.layer.shadowColor = UIColor.darkGray.cgColor
            button.layer.shadowOffset = CGSize(width: 0, height: 2)
            button.layer.shadowOpacity = 0.4
            button.layer.shadowRadius = 3
        }
    }
}

