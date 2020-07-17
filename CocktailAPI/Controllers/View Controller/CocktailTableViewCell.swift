//
//  CocktailTableViewCell.swift
//  CocktailAPI
//
//  Created by adetokunbo babatunde on 6/17/20.
//  Copyright © 2020 AdetokunboBabatunde. All rights reserved.
//

import UIKit

class CocktailTableViewCell: UITableViewCell {

    @IBOutlet weak var cocktailImageView: UIImageView!
    @IBOutlet weak var cocktailLabel: UILabel!
    
    var cocktail: Cocktail? {
        didSet {
            updateViews()
        }
    }
    
    func updateViews() {
        guard let cocktail = cocktail else {return}
        cocktailImageView.image = nil
        cocktailLabel.text = cocktail.strDrink
        
        CocktailController.fetchImage(cocktail: cocktail) { [weak self] (result) in
            switch result{
            case .success(let image):
                DispatchQueue.main.async {
                    self?.cocktailImageView.image = image
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
