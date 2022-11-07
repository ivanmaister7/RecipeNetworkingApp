//
//  ClassifyingCuisineViewController.swift
//  RecipeNetworkingApp
//
//  Created by Dmytro Hetman on 06.11.2022.
//

import UIKit

class ClassifyingCuisineViewController: UIViewController {

    
    var ingredientList = ""
    var dishTitle = ""
    

    
    @IBOutlet weak var classifiedCuisineLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        classifiedCuisineLabel.adjustsFontSizeToFitWidth = true
        getCuisine()
    }
    
    func getCuisine() {
//        Task {
//            if let nameOf = await ClassifyCuisineResults().classifyCuisine(of: dishTitle, by: ingredientList) {
//                DispatchQueue.main.async {
//                    self.classifiedCuisineLabel.text = nameOf.cuisine + " cuisine"
//                }
//            }
//        }
    }
    
}


