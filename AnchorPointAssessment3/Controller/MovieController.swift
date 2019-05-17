//
//  MovieController.swift
//  AnchorPointAssessment3
//
//  Created by Kaden Hendrickson on 5/17/19.
//  Copyright © 2019 DevMountain. All rights reserved.
//

import UIKit

class MovieController {
    
    static let shared = MovieController()

    
    
    func fetchMovieWith(searchTerm: String, completion: @escaping ([Movie]) -> Void) {
        
        let baseURL = URL(string: "https://api.themoviedb.org/3/search")
        
        guard var url = baseURL else {completion([]); return}
        url.appendPathComponent("movie")
        
        var component = URLComponents(url: url, resolvingAgainstBaseURL: true)
        let apiQuery = URLQueryItem(name: "api_key", value: "7ed00d40e160dd61f515efe943e4777a")
        let searchTermQuery = URLQueryItem(name: "query", value: searchTerm)
        component?.queryItems = [apiQuery, searchTermQuery]
        
        guard let finalURL = component?.url else {completion([]); return}
        
        URLSession.shared.dataTask(with: finalURL) { (data, _, error) in
            if let error = error {
                print("😝There was an error initiating data task: \(error.localizedDescription)😝")
            }
            
            guard let data = data else {completion([]); return}
            
            do{
              let topLevelJSONData = try JSONDecoder().decode(TopLevelJson.self, from: data)
                let results = topLevelJSONData.results
                completion(results)
            } catch {
                print("😝There was an error decoding movie: \(searchTerm) -- \(error.localizedDescription)😝")
            }
        }.resume()
    }
    
    func fetchMovieImageWith(movie: Movie, completion: @escaping (UIImage?) -> Void) {
        let baseURL = URL(string: "https://image.tmdb.org/t/p/w500/")
        
        guard var url = baseURL, let image = movie.imageURL else {completion(nil); return}
        url.appendPathComponent(image)
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                print("Image for \(movie.title) could not be found! : \(error.localizedDescription)")
            }
            guard let data = data else {completion(nil); return}
            
            let image = UIImage(data: data)
            completion(image)
            
    }.resume()
}
}
