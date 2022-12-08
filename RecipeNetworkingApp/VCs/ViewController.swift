//
//  ViewController.swift
//  RecipeNetworkingApp
//
//  Created by Master on 03.11.2022.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet private weak var searchDishBar: UISearchBar!
    @IBOutlet private weak var searchDishTable: UITableView!
    
    var searchText = ""
    var currentDishTitle = ""
    
    var networkService: AlamoNetworking<RecipesEndpoint>? = nil
    
    var searchDishesResult: [DishSearch] = []
    var searchDishesDetails: [DishDetails] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchDishBar.delegate = self
        searchDishTable.dataSource = self
        
        searchDishTable.keyboardDismissMode = .onDrag
        
        networkService = AlamoNetworking<RecipesEndpoint>("https://spoonacular-recipe-food-nutrition-v1.p.rapidapi.com", headers: Const.headers)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let indexPath = searchDishTable.indexPathForSelectedRow{
            let selectedRow = indexPath.row
            let dishDetails = segue.destination as! DishDetailsViewController
            
            dishDetails.currentDish = self.searchDishesResult[selectedRow]
            print("searchDishesResult : \(searchDishesResult.count)")
            print("searchDishesDetails : \(searchDishesDetails.count)")
            print(self.searchDishesResult[selectedRow].id)
            let details = self.searchDishesDetails.first(){
                $0.id == self.searchDishesResult[selectedRow].id
            }
            if let details = details {
                dishDetails.currentDishDetails = details
            }
        }
    }
        
    func searchDishesRequest() {
        guard let networkService = networkService else { return }
            networkService.perform(.get, .search,
                                   RecipeSearch([URLQueryItem(name: "query",
                                                              value: searchText)])) { result in
                switch result {
                case .data(let data):
                  guard let data = data,
                        let searchDishesResult = try? JSONDecoder().decode(SearchResponce.self, from: data) else { return }
                  DispatchQueue.main.async {
                    self.searchDishesResult = searchDishesResult.results
                    self.searchDishTable.reloadData()
                    self.searchDishesResult.forEach(){
                        self.getDishesDetails(id: $0.id)
                    }
                  }
                case .error(_):
                    break
                }
            }
    }
    
    func getDishesDetails(id: Int) {
        guard let networkService = networkService else { return }
        networkService.perform(.get, .information, id,
                                   RecipeInfoSearch()) { result in
                switch result {
                case .data(let data):
                  guard let data = data,
                        let searchDishInfoResult = try? JSONDecoder().decode(DishDetails.self, from: data) else { return }
                  DispatchQueue.main.async {
                    self.searchDishesDetails.append(searchDishInfoResult)
                  }
                case .error(_):
                    break
                }
            }
    }

    @IBAction func searchButtonTap(_ sender: Any) {
        searchDishesRequest()
    }
    
    
}


extension ViewController: UITableViewDataSource, UISearchBarDelegate, UIPopoverPresentationControllerDelegate, SearchCellDelegate {
    func guessNutrition(_ sender: Any) {
        
    }
    
    func guessNutrition(_ sender: Any, of title: String) {
        let button = sender as? UIButton
        let popoverContentController = self.storyboard?.instantiateViewController(withIdentifier: "DishNutritionController") as? DishNutritionViewController
        popoverContentController?.modalPresentationStyle = .popover

        if let popoverPresentationController = popoverContentController?.popoverPresentationController {
           popoverPresentationController.permittedArrowDirections = .up
            popoverPresentationController.sourceView = button
           popoverPresentationController.delegate = self
           if let popoverController = popoverContentController {
               popoverController.dishTitle = title
               present(popoverController, animated: true)
           }
        }
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.searchText = searchText
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        searchDishesResult.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell_id", for: indexPath) as! SearchCell
        cell.delegate = self
        
        let data = searchDishesResult[indexPath.row]
        
        cell.confView(for: data)
        return cell
    }

    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        .none
    }
}
