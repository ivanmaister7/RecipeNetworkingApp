//
//  SearchResponce.swift
//  RecipeNetworkingApp
//
//  Created by Master on 04.11.2022.
//

import Foundation

struct SearchResponce: Codable {
    let number: Int
    let totalResults: Int
    let results: [DishSearch]
}
