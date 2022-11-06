//
//  EndpointsInstructions.swift
//  RecipeNetworkingApp
//
//  Created by Dmytro Hetman on 07.11.2022.
//

import Foundation

protocol NetworkRequestBodyConvertible {
    
    var data: Data? { get }
    var queryItems: [URLQueryItem]? { get }
    var parameters: [String : Any]? { get }
    
}

struct RecipeAnalyzeInstruction: NetworkRequestBodyConvertible {
    var text: String
    
    init(_ text: String) {
        self.text = text
    }
    
    var data: Data? {
        "instructions=\(text)".data(using: .utf8)
    }
    var queryItems: [URLQueryItem]? { nil }
    var parameters: [String : Any]? {
        ["instructions" : text]
    }
}

struct RecipeSearch: NetworkRequestBodyConvertible {
    
    init(_ queryItems: [URLQueryItem]?) {
        self.queryItems = queryItems
    }
    var data: Data? { nil }
    var queryItems: [URLQueryItem]?
    var parameters: [String : Any]? { nil }
    
}

struct GuessNutritionInstruction: NetworkRequestBodyConvertible {
    var title: String
    
    init(title: String) {
        self.title = title
    }
    
    var data: Data? { nil }
    
    var queryItems: [URLQueryItem]? {
        [URLQueryItem(name: "title", value: title)]
    }
    var parameters: [String : Any]? {
        ["title" : title]
    }
}

struct ClassifyCuisineInstruction: NetworkRequestBodyConvertible {
    
    var title: String
    var ingredientList: String
    
    init(title: String, ingredientList: String) {
        self.title = title
        self.ingredientList = ingredientList
    }
    
    var data: Data? {
        "ingredientList=\(ingredientList)&title\(title)".data(using: .utf8)
    }
    
    var queryItems: [URLQueryItem]? { nil }
    
    var parameters: [String : Any]? {
        ["ingredientList" : ingredientList, "title" : title]
    }
    
    
}
