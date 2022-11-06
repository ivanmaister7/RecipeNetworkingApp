//
//  ClassifyingCuisineViewController.swift
//  RecipeNetworkingApp
//
//  Created by Dmytro Hetman on 06.11.2022.
//

import UIKit

class ClassifyingCuisineViewController: UIViewController {

    var dishTitle = ""
    

    
    @IBOutlet weak var classifiedCuisineLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        classifiedCuisineLabel.text = dishTitle
    }
    
}


