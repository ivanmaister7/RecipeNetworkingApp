//
//  ViewController.swift
//  RecipeNetworkingApp
//
//  Created by Master on 03.11.2022.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var searchDishBar: UISearchBar!
    @IBOutlet weak var searchDishTable: UITableView!
    
    var searchText = ""
    var count = 2
    
    let headers = [
        "content-type": "application/x-www-form-urlencoded",
        "X-RapidAPI-Key": "c16730d1cfmshb29acd971c9d77bp10617djsn47827102600d",
        "X-RapidAPI-Host": "spoonacular-recipe-food-nutrition-v1.p.rapidapi.com"
    ]
    
    var networkService: AlamoNetworking<RecipesEndpoint>? = nil
    
    var searchDishesResult: [DishSearch] = [
        DishSearch(id: 376941,image: "https://spoonacular.com/recipeImages/376941-312x231.jpeg",
                   title: "Pasta Rosa")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchDishBar.delegate = self
        searchDishTable.dataSource = self
        
        searchDishTable.keyboardDismissMode = .onDrag
        
            networkService = AlamoNetworking<RecipesEndpoint>("https://spoonacular-recipe-food-nutrition-v1.p.rapidapi.com", headers: headers)
        
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
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let indexPath = searchDishTable.indexPathForSelectedRow{
            let selectedRow = indexPath.row
            let dishDetails = segue.destination as! DishDetailsViewController
            dishDetails.currentDish = self.searchDishesResult[selectedRow]
        }
    }
        
    func searchDishesRequest() {
//        searchDishesResult = Array(repeating:
//                                    DishSearch(id: count,
//                                               image: "https://spoonacular.com/recipeImages/376941-312x231.jpeg",
//                                               title: "Pasta Rosa"),count: count)
//        count+=1
 //       self.searchDishTable.reloadData()
            
            networkService!.perform(.get, .search,
                                   RecipeSearch([URLQueryItem(name: "query",
                                                              value: searchText)])) { result in
                switch result {
                case .data(let data):
                    print("RESULT")
                  guard let data = data,
                        let searchDishesResult = try? JSONDecoder().decode(SearchResponce.self, from: data) else { return }
                  DispatchQueue.main.async {
                    self.searchDishesResult = searchDishesResult.results
                    self.searchDishTable.reloadData()
                  }
                case .error(_):
                    print("ERROR")
                    break
                }
            }
        
    }

    @IBAction func searchButtonTap(_ sender: Any) {
        searchDishesRequest()
    }
    
    @IBAction func guessButtonTap(_ sender: Any) {
        // move to guess nutrition view controller
    }
}


extension ViewController: UITableViewDataSource, UISearchBarDelegate{
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.searchText = searchText
    }
    
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

