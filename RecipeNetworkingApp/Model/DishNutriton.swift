//
//  DishNutriton.swift
//  RecipeNetworkingApp
//
//  Created by Dmytro Hetman on 05.11.2022.
//

import Foundation

struct DishNutrition: Codable {
    
    let calories: NutritionValue
    let fat: NutritionValue
    let protein: NutritionValue
    let carbs: NutritionValue
    
    struct NutritionValue: Codable {
        var value: Int
        var unit: String
    }
    
}
