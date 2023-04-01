//
//  TrainViewController.swift
//  MathTrainerApp
//
//  Created by Даниил Павленко on 01.04.2023.
//

import UIKit

final class TrainViewController: UIViewController {
    // MARK: Properties
    var type: MathTypes = .add {
        didSet{
            print(type)
        }
    }
}
