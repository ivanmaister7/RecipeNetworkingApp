//
//  SearchCell.swift
//  RecipeNetworkingApp
//
//  Created by Master on 03.11.2022.
//

import Foundation
import UIKit
import SDWebImage

class SearchCell: UITableViewCell, UIPopoverPresentationControllerDelegate {
    
    // MARK: - IBOutlets
    @IBOutlet private weak var dishImage: UIImageView!
    @IBOutlet private weak var dishNameLabel: UILabel!
    @IBOutlet private weak var guessNutritionButton: UIButton!
    
    weak var delegate: SearchCellDelegate?
    
    // MARK: - IBActions
    @IBAction func guessNutritionByDishName(_ sender: Any) {
        delegate?.guessNutrition(sender)
    }
    
    func confView(for dish: DishSearch ) {
        self.guessNutritionButton.setTitle("", for: .normal)
        self.dishImage.sd_setImage(with: URL(string: dish.image), completed: nil)
        //self.dishImage.image = UIImage(named: "default")
        self.dishNameLabel.text = dish.title
    }
}

protocol SearchCellDelegate: AnyObject {
    func guessNutrition(_ sender: Any)
}

