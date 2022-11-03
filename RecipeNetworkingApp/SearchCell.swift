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
    @IBOutlet weak var dishImage: UIImageView!
    @IBOutlet weak var dishNameLabel: UILabel!
    
    func confView(for dish: DishSearch ) {
        //self.dishImage.sd_setImage(with: URL(string: dish.imageUrl), completed: nil)
        self.dishImage.image = UIImage(named: "default")
        self.dishNameLabel.text = dish.dishName
    }
}

