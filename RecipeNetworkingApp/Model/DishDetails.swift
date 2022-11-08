//
//  DishDetails.swift
//  RecipeNetworkingApp
//
//  Created by Master on 08.11.2022.
//

import Foundation

struct DishDetails: Codable {
    let id: Int
    let image: String
    let title: String
    let summary: String
    let readyInMinutes: Int
    let instructions: String?
    let extendedIngredients: [Ingredient]
}
