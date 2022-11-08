//
//  Const.swift
//  RecipeNetworkingApp
//
//  Created by Dmytro Hetman on 07.11.2022.
//

import Foundation

struct Const {
    static let headers = [
        "content-type": "application/x-www-form-urlencoded",
        "X-RapidAPI-Key": "c16730d1cfmshb29acd971c9d77bp10617djsn47827102600d",
        "X-RapidAPI-Host": "spoonacular-recipe-food-nutrition-v1.p.rapidapi.com"
    ]
    static let DEFAULT_DISH = DishSearch(id: 376941,
                                 image: "https://spoonacular.com/recipeImages/376941-312x231.jpeg",
                                 title: "Pasta Rosa")
    static let DEFAULT_DETAILS = DishDetails(id: 376941,
                                         image: "https://spoonacular.com/recipeImages/376941-312x231.jpeg",
                                         title: "Pasta Rosa",
                                         summary: "...",
                                         cookingMinutes: 15,
                                         instructions: "...",
                                         extendedIngredients: [Ingredient(
                                                                id:12147,
                                                                image:"pine-nuts.png",
                                                                name:"pine nuts",
                                                                original:"1/2 cup pine nuts")])
}
