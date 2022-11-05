//
//  DishDetailsViewController.swift
//  RecipeNetworkingApp
//
//  Created by Master on 04.11.2022.
//

import Foundation
import UIKit

class DishDetailsViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var testlabel: UILabel!

    
    // MARK: - IBActions
    @IBAction func classifyCuisine(_ sender: Any) {
        
    }
    
    // MARK: - Variables
    var currentDish = DishSearch(id: 376941,
                                 image: "https://spoonacular.com/recipeImages/376941-312x231.jpeg",
                                 title: "Pasta Rosa")
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        testlabel.text = "id: \(currentDish.id)"
    }
}
