//
//  DishNutritionViewController.swift
//  RecipeNetworkingApp
//
//  Created by Dmytro Hetman on 06.11.2022.
//

import UIKit

class DishNutritionViewController: UIViewController {

    var dishTitle = ""
    
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
            if let nutritions = await DishNutritionResults.guessNutrition(of: dishTitle) {
                DispatchQueue.main.async {
                    
                    self.caloriesUnits.text = "\(nutritions.calories?.value ?? 0) \(nutritions.calories?.unit ?? "no data")"

                    self.fatUnits.text = "\(nutritions.fat?.value ?? 0) \(nutritions.fat?.unit ?? "no data")"
                    self.proteinUnits.text = "\(nutritions.protein?.value ?? 0) \(nutritions.protein?.unit ?? "no data")"
                    self.carbsUnits.text = "\(nutritions.carbs?.value ?? 0) \(nutritions.carbs?.unit ?? "no data")"
                }
                
            }
        }
    }

}


