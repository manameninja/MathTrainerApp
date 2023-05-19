//
//  ViewController.swift
//  MathTrainerApp
//
//  Created by Даниил Павленко on 01.04.2023.
//

import UIKit

enum MathTypes: Int, CaseIterable {
    case add, subtract, multiply, divide
    
    var key: String {
        switch self {
        case .add:
            return "addCount"
        case .subtract:
            return "subtractCount"
        case .multiply:
            return "multiplyCount"
        case .divide:
            return "divideCount"
        }
    }
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
        
        setCountLabels()
        configureButtons()
    }
    
    // MARK: - IBAction
    @IBAction func clearButtonAction(_ sender: Any) {
        let alert = UIAlertController(title: "Предупреждение", message: "Вы действительно хотите обнулить очки?", preferredStyle: .alert)
        let noAction = UIAlertAction(title: "Нет", style: .destructive)
        let yesAction = UIAlertAction(title: "Да", style: .default, handler: { action in
            MathTypes.allCases.forEach { type in
                let key = type.key
                
                UserDefaults.standard.removeObject(forKey: key)
                self.clearLabels()
            }
        })
        
        alert.addAction(yesAction)
        alert.addAction(noAction)
        present(alert, animated: true)
    }
    
    @IBAction func buttonsAction(_ sender: UIButton) {
        selectedType = MathTypes(rawValue: sender.tag) ?? .add
        performSegue(withIdentifier: "goToNext", sender: sender)
    }
    
    @IBAction func unwindAction(unwindSegue: UIStoryboardSegue) {
        setCountLabels()
    }
    
    
    
    // MARK: - Methods
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewController = segue.destination as? TrainViewController {
            viewController.type = selectedType
        }
    }
    
    // MARK: - Private Methods
    private func clearLabels() {
        addLabel.text = "-"
        subtractLabel.text = "-"
        multiplyLabel.text = "-"
        divideLabel.text = "-"
    }
    
    private func setCountLabels() {
        MathTypes.allCases.forEach { type in
            let key = type.key
            guard let count = UserDefaults.standard.object(forKey: key) as? Int else { return }
            let stringCount = String(count)
            
            switch type {
            case .add:
                addLabel.text = stringCount
            case .subtract:
                subtractLabel.text = stringCount
            case .multiply:
                multiplyLabel.text = stringCount
            case .divide:
                divideLabel.text = stringCount
            }
        }
    }
    
    private func configureButtons() {
        // Add shadow
        buttonsCollection.forEach { button in
            button.layer.shadowColor = UIColor.darkGray.cgColor
            button.layer.shadowOffset = CGSize(width: 0, height: 2)
            button.layer.shadowOpacity = 0.4
            button.layer.shadowRadius = 3
        }
    }
}
