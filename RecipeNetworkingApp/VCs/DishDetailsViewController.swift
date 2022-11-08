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
    var currentDishDetails = DishDetails(id: 376941,
                                         image: "https://spoonacular.com/recipeImages/376941-312x231.jpeg",
                                         title: "Pasta Rosa",
                                         summary: "...",
                                         cookingMinutes: 15,
                                         instructions: "...",
                                         extendedIngredients: [Ingredient(
                                                                id:12147,
                                                                image:"pine-nuts.png",
                                                                name:"pine nuts",
                                                                original:"1/2 cup pine nuts")])
    var cuisine = ""
    var dishTitle = ""
    var ingredientList = ""
    
    let headers = [
        "content-type": "application/x-www-form-urlencoded",
        "X-RapidAPI-Key": "c16730d1cfmshb29acd971c9d77bp10617djsn47827102600d",
        "X-RapidAPI-Host": "spoonacular-recipe-food-nutrition-v1.p.rapidapi.com"
    ]
    
    var networkService: AlamoNetworking<RecipesEndpoint>? = nil
    
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        //classifyCuisineButton.setTitle("Clasiffy", for: .normal)
        networkService = AlamoNetworking<RecipesEndpoint>("https://spoonacular-recipe-food-nutrition-v1.p.rapidapi.com", headers: headers)
        testlabel.text = "id: \(currentDish.id) ± \(currentDishDetails.title)"
        searchDishesDetails(id: currentDish.id) { result in
            self.currentDishDetails = result
        }
        // here put currentDish title and ingredientList
        dishTitle = "Pork roast with green beans"
        ingredientList = "3 oz pork shoulder"
        getCuisine()
    }
    
    func searchDishesDetails(id: Int, completion: @escaping (DishDetails) -> ()) {
        networkService!.perform(.get, .information, id,
                                   RecipeInfoSearch()) { result in
                switch result {
                case .data(let data):
                  guard let data = data,
                        let searchDishInfoResult = try? JSONDecoder().decode(DishDetails.self, from: data) else { return }
                  DispatchQueue.main.async {
                    completion(searchDishInfoResult)
                    self.view.setNeedsDisplay()
                  }
                case .error(_):
                    break
                }
            }
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


