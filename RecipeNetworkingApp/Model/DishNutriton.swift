//
//  DishNutriton.swift
//  RecipeNetworkingApp
//
//  Created by Dmytro Hetman on 05.11.2022.
//

import Foundation

struct DishNutritionResults: Codable {
    
    var calories: Nutrition
    var fat: Nutrition
    var protein: Nutrition
    var carbs: Nutrition
    
//    func guessNutrition(of title: String) async -> DishNutritionResults? {
//        do {
//            let networkService = try Network<RecipesEndpoint>("https://spoonacular-recipe-food-nutrition-v1.p.rapidapi.com", headers: Const.headers)
//            let data = try? await networkService.perform(.get, .guess, GuessNutritionInstruction(title: title))
//            if let data = data {
//                let result = try JSONDecoder().decode(DishNutritionResults.self, from: data)
//                print(result)
//                return result
//            }
//            
//        } catch {
//            
//            print(error)
//        }
//        return nil
//    }
    
    struct Nutrition: Codable {
        var value: Int
        var unit: String
    }
    
}
