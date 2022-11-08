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
    @IBOutlet private weak var testlabel: UILabel!
    @IBOutlet private weak var classifyCuisineButton: UIButton!
    
    // MARK: - IBActions
    @IBAction func classifyCuisine(_ sender: Any) {
        let popoverContentController = self.storyboard?.instantiateViewController(withIdentifier: "ClassifyingCuisineViewController") as? ClassifyingCuisineViewController
        popoverContentController?.modalPresentationStyle = .popover

        if let popoverPresentationController = popoverContentController?.popoverPresentationController {
            popoverPresentationController.permittedArrowDirections = .up
            popoverPresentationController.sourceView = self.classifyCuisineButton
            popoverPresentationController.delegate = self
            if let popoverController = popoverContentController {
                popoverController.cuisine = self.cuisine
                popoverController.preferredContentSize = CGSize(width: self.view.frame.width/1.5, height: self.view.frame.width/5)
                present(popoverController, animated: true)
            }
        }
    }
    
    // MARK: - Variables
    var currentDish = DishSearch(id: 376941,
                                 image: "https://spoonacular.com/recipeImages/376941-312x231.jpeg",
                                 title: "Pasta Rosa")
    var cuisine = ""
    var dishTitle = ""
    var ingredientList = ""
    
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        //classifyCuisineButton.setTitle("Clasiffy", for: .normal)
        testlabel.text = "id: \(currentDish.id)"
        // here put currentDish title and ingredientList
        dishTitle = "Pork roast with green beans"
        ingredientList = "3 oz pork shoulder"
        getCuisine()
    }
    
    func getCuisine() {
//        Task {
//            if let nameOf = await ClassifyCuisineResults().classifyCuisine(of: dishTitle, by: ingredientList) {
//                DispatchQueue.main.async {
//                    print(self.dishTitle)
//                    print(self.ingredientList)
//                    self.cuisine = nameOf.cuisine + " cuisine"
//                }
//            }
//        }
    }
    
}

extension DishDetailsViewController: UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        .none
    }
}


