//
//  CocktailListTableViewController.swift
//  CocktailAPI
//
//  Created by adetokunbo babatunde on 6/17/20.
//  Copyright © 2020 AdetokunboBabatunde. All rights reserved.
//

import UIKit

protocol presentErrorToUserDelegate: class {
    func presentErrorToUser(error: LocalizedError)
}

class CocktailListTableViewController: UITableViewController {

    //MARK: - Properties
    var cocktails: [Cocktail] = []
    
    //MARK: - Outlets
    @IBOutlet weak var cocktailSearchBar: UISearchBar!
    override func viewDidLoad() {
        super.viewDidLoad()
        cocktailSearchBar.delegate = self

    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cocktails.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cocktailCell", for: indexPath) as? CocktailTableViewCell else {return UITableViewCell()}
       
        let cocktail = cocktails[indexPath.row]
        cell.cocktail = cocktail
        return cell
    }

}

//MARK: - Extensions
extension CocktailListTableViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text, !searchTerm.isEmpty else { return }
        CocktailController.fetchCocktail(searchTerm: searchTerm) { [weak self] (result) in
            switch result {
            case .success(let cocktail):
                self?.cocktails = cocktail
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

