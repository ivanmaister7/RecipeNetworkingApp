//
//  DishDetailsViewController.swift
//  RecipeNetworkingApp
//
//  Created by Master on 04.11.2022.
//

import Foundation
import UIKit
import SDWebImage

class DishDetailsViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var cookingTimeLabel: UILabel!
    @IBOutlet private weak var dishInfoLabel: UILabel!
    @IBOutlet private weak var ingredientsLabel: UILabel!
    @IBOutlet private weak var instructionLabel: UILabel!
    @IBOutlet private weak var imageLabel: UIImageView!
    @IBOutlet private weak var classifyCuisineButton: UIButton!
    
    // MARK: - Variables
    var currentDish = Const.DEFAULT_DISH
    var currentDishDetails = Const.DEFAULT_DETAILS
    var cuisine = ""
    var dishTitle = ""
    var ingredientList = ""
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        //classifyCuisineButton.setTitle("Clasiffy", for: .normal)
        titleLabel.text = currentDishDetails.title
        imageLabel.sd_setImage(with: URL(string: currentDishDetails.image), completed: nil)
        dishInfoLabel.text = proccesingText(text: currentDishDetails.summary)
        cookingTimeLabel.text = "\(currentDishDetails.readyInMinutes) min"
        let ingredients = currentDishDetails.extendedIngredients.reduce("") {
            $0 + "🔪 \(proccesingText(text: $1.original))\n"
        }
        ingredientsLabel.text = ingredients
        instructionLabel.text = proccesingText(text: currentDishDetails.instructions ?? "Put all ingredients and mix it :)")
        // here put currentDish title and ingredientList
        dishTitle = currentDishDetails.title
        ingredientList = currentDishDetails.extendedIngredients.first?.original ?? "3 oz pork shoulder"
        getCuisine()
    }
    
    func proccesingText(text: String) -> String {
        var dishInfoLabelText = ""
        for (index, elem) in text.enumerated() {
            dishInfoLabelText += "\(elem)"
            if index % 35 == 0 && index != 0{
                dishInfoLabelText += "\n"
            }
        }
        return dishInfoLabelText
            .replacingOccurrences(of: "<b>", with: " ")
            .replacingOccurrences(of: "</b>", with: " ")
    }
    
    func getCuisine() {
        Task {
            if let nameOf = await ClassifyCuisineResults.classifyCuisine(of: dishTitle, by: ingredientList) {
                DispatchQueue.main.async {
                    print(self.dishTitle)
                    print(self.ingredientList)
                    self.cuisine = nameOf.cuisine + " cuisine"
                }
            }
        }
    }
    
    
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
    
}

extension DishDetailsViewController: UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        .none
    }
}


