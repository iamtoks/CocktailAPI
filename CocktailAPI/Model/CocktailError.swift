//
//  CocktailError.swift
//  CocktailAPI
//
//  Created by adetokunbo babatunde on 6/17/20.
//  Copyright © 2020 AdetokunboBabatunde. All rights reserved.
//

import Foundation

enum CocktailError: LocalizedError{
    case invalidError
    case thrownError(Error)
    case noData
    case unableToDecode
}
