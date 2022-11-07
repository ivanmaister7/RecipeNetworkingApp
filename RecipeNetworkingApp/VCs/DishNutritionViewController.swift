//
//  DishNutritionViewController.swift
//  RecipeNetworkingApp
//
//  Created by Dmytro Hetman on 06.11.2022.
//

import UIKit

class DishNutritionViewController: UIViewController {

    var dishTitle = "Pasta Rosa"
    
    @IBOutlet private weak var caloriesUnits: UILabel!
    @IBOutlet private weak var fatUnits: UILabel!
    @IBOutlet private weak var proteinUnits: UILabel!
    @IBOutlet private weak var carbsUnits: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getNutritions()
        
    }
    
    func getNutritions() {
        Task {
            if let nutritions = await DishNutritionResults().guessNutrition(of: dishTitle) {
                DispatchQueue.main.async {
                    self.caloriesUnits.text = "\(nutritions.calories.value)  "
                    print(nutritions.fat)
                    self.fatUnits.text = "\(nutritions.fat.value) \(nutritions.fat.unit)"
                    self.proteinUnits.text = "\(nutritions.protein.value) \(nutritions.protein.unit)"
                    self.carbsUnits.text = "\(nutritions.carbs.value) \(nutritions.carbs.unit)"
                }
                
            } 
        }
    }

}


