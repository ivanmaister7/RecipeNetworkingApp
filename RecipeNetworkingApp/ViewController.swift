//
//  ViewController.swift
//  RecipeNetworkingApp
//
//  Created by Master on 03.11.2022.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var searchDishTable: UITableView!
    
    var searchDishesResult: [DishSearch] = [
        DishSearch(imageUrl: "https://spoonacular.com/recipeImages/376941-312x231.jpeg",
                   dishName: "Pasta Rosa")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchDishTable.dataSource = self
        
        let headers = [
            "content-type": "application/x-www-form-urlencoded",
            "X-RapidAPI-Key": "c16730d1cfmshb29acd971c9d77bp10617djsn47827102600d",
            "X-RapidAPI-Host": "spoonacular-recipe-food-nutrition-v1.p.rapidapi.com"
        ]
        
        let networkService = AlamoNetworking<RecipesEndpoint>("https://spoonacular-recipe-food-nutrition-v1.p.rapidapi.com", headers: headers)
        
//        networkService.perform(.post, .analyzer, RecipeAnalyzeInstruction("Fried potatoe with chicken, onions and cheese")) { result in
//            switch result {
//            case .data(let data):
//                print("RESULT")
//                print(try! JSONSerialization.jsonObject(with: data!))
//            case .error(_):
//                print("ERROR")
//                break
//            }
//        }
//        networkService.perform(.get, .search,
//                               RecipeSearch([URLQueryItem(name: "query",
//                                                          value: "pasta")])) { result in
//            switch result {
//            case .data(let data):
//                print("RESULT")
//                print(try! JSONSerialization.jsonObject(with: data!))
//            case .error(_):
//                print("ERROR")
//                break
//            }
//        }
    }

}
extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        searchDishesResult.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell_id", for: indexPath) as! SearchCell
        let data = searchDishesResult[indexPath.row]
        cell.confView(for: data)
        return cell
    }
    
    
}

