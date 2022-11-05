//
//  SearchCell.swift
//  RecipeNetworkingApp
//
//  Created by Master on 03.11.2022.
//

import Foundation
import UIKit
import SDWebImage

class SearchCell: UITableViewCell {
    
    // MARK: - IBOutlets
    @IBOutlet weak var dishImage: UIImageView!
    @IBOutlet weak var dishNameLabel: UILabel!
    
    // MARK: - IBActions
    @IBAction func guessNutritionByDishName(_ sender: Any) {
        
    }
    
    func confView(for dish: DishSearch ) {
        self.dishImage.sd_setImage(with: URL(string: dish.image), completed: nil)
        //self.dishImage.image = UIImage(named: "default")
        self.dishNameLabel.text = dish.title
    }
}

