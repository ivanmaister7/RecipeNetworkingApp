//
//  DishNutriton.swift
//  RecipeNetworkingApp
//
//  Created by Dmytro Hetman on 05.11.2022.
//

import Foundation

struct NutritionResults: Codable {
    
    let calories: Nutrition
    let fat: Nutrition
    let protein: Nutrition
    let carbs: Nutrition
    
    func guessNutrition(of title: String)  {
        
    }
    
    struct Nutrition: Codable {
        var value: Int
        var unit: String
    }
    
}
