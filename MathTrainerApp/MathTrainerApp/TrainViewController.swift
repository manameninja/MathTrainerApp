//
//  TrainViewController.swift
//  MathTrainerApp
//
//  Created by Даниил Павленко on 01.04.2023.
//

import UIKit

final class TrainViewController: UIViewController {
    @IBOutlet var buttonsTrainerCollection: [UIButton]!
    // MARK: Properties
    var type: MathTypes = .add {
        didSet{
            print(type)
        }
    }
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configurateButtonsTrainer()
    }
    
    private func configurateButtonsTrainer() {
        // Add shadow
        buttonsTrainerCollection.forEach { button in
            button.layer.shadowColor = UIColor.darkGray.cgColor
            button.layer.shadowOffset = CGSize(width: 0, height: 2)
            button.layer.shadowOpacity = 0.4
            button.layer.shadowRadius = 3
        }
    }
}
