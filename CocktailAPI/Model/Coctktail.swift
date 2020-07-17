//
//  Coctktail.swift
//  CocktailAPI
//
//  Created by adetokunbo babatunde on 6/17/20.
//  Copyright © 2020 AdetokunboBabatunde. All rights reserved.
//

import Foundation

struct TopLevelObject: Decodable {
    let drinks: [Cocktail]
}


struct Cocktail: Decodable {
    let strDrink: String
    let strDrinkThumb: URL?
}
