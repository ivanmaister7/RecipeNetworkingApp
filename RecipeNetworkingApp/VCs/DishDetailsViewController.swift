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
                popoverController.dishTitle = self.currentDish.title
                popoverController.preferredContentSize = CGSize(width: self.view.frame.width/1.5, height: self.view.frame.width/5)
                present(popoverController, animated: true)
            }
        }
    }
    
    // MARK: - Variables
    var currentDish = DishSearch(id: 376941,
                                 image: "https://spoonacular.com/recipeImages/376941-312x231.jpeg",
                                 title: "Pasta Rosa")
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        classifyCuisineButton.setTitle("", for: .normal)
        testlabel.text = "id: \(currentDish.id)"
    }
    
}

extension DishDetailsViewController: UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        .none
    }
}

