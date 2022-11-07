//
//  ClassifyingCuisineViewController.swift
//  RecipeNetworkingApp
//
//  Created by Dmytro Hetman on 06.11.2022.
//

import UIKit

class ClassifyingCuisineViewController: UIViewController {

    @IBOutlet weak var classifiedCuisineLabel: UILabel!
    
    var cuisine = ""
        
        override func viewDidLoad() {
            super.viewDidLoad()
            classifiedCuisineLabel.adjustsFontSizeToFitWidth = true
            DispatchQueue.main.async {
                self.classifiedCuisineLabel.text = self.cuisine
            }
        }
}


