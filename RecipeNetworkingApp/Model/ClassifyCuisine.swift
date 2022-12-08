//
//  ClassifyCuisine.swift
//  RecipeNetworkingApp
//
//  Created by Dmytro Hetman on 07.11.2022.
//

import Foundation

struct ClassifyCuisineResults: Codable {
    
    var cuisine: String
    
    static func classifyCuisine(of title: String, by ingredientList: String) async -> ClassifyCuisineResults? {
        
        do {
            let networkService = try Network<RecipesEndpoint>("https://spoonacular-recipe-food-nutrition-v1.p.rapidapi.com", headers: Const.headers)
            let data = try? await networkService.perform(.post, .classify, ClassifyCuisineInstruction(title: title, ingredientList: ingredientList))
            
            if let data = data {
                let result = try JSONDecoder().decode(ClassifyCuisineResults.self, from: data)
                return result
            }
            
        } catch {
            print(error)
        }
        
        return nil
    }
    
}
