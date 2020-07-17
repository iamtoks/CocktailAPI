//
//  CocktailController.swift
//  CocktailAPI
//
//  Created by adetokunbo babatunde on 6/17/20.
//  Copyright © 2020 AdetokunboBabatunde. All rights reserved.
//

import UIKit

struct StringComponent {
    fileprivate static let baseURL = "https://www.thecocktaildb.com/api/json/v1/1"
    fileprivate static let searchComponentString = "search"
    fileprivate static let fileExtension = "php"
}

class CocktailController {
    
    static func fetchCocktail(searchTerm: String, completion: @escaping (Result<[Cocktail], CocktailError>) -> Void) {
       
        guard let baseURL = URL(string: StringComponent.baseURL) else {return completion(.failure(.invalidError))}
        let searchCompnentString = baseURL.appendingPathComponent(StringComponent.searchComponentString)
        let fileExtension = searchCompnentString.appendingPathExtension(StringComponent.fileExtension)
        var components = URLComponents(url: fileExtension, resolvingAgainstBaseURL: true)
        components?.queryItems = [URLQueryItem(name: "f", value: searchTerm.lowercased())]
        
        guard let finalURL = components?.url else {return completion(.failure(.invalidError))}
        print(finalURL)
        
        URLSession.shared.dataTask(with: finalURL) { (data, _, error) in
            if let error = error {
                return completion(.failure(.thrownError(error)))
            }
            
            guard let data = data else { return completion(.failure(.noData))}
            do {
                let topLevelObject = try JSONDecoder().decode(TopLevelObject.self, from: data)
                let cocktailArray = topLevelObject.drinks
                completion(.success(cocktailArray))
            } catch {
                return completion(.failure(.thrownError(error)))
            }
        }.resume()
    }
    
    static func fetchImage(cocktail: Cocktail, completion: @escaping (Result<UIImage, CocktailError>) -> Void ){
        guard let url = cocktail.strDrinkThumb else {return}
        print(url)
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                return completion(.failure(.thrownError(error)))
            }
            
            guard let data = data else {return completion(.failure(.noData))}
            
            guard let thumbnailImage = UIImage(data: data) else {return completion(.failure(.unableToDecode))}
            completion(.success(thumbnailImage))
        }.resume()
    }
}
