//
//  MovieController.swift
//  MoiveForTea
//
//  Created by Thao Doan on 5/25/18.
//  Copyright © 2018 Thao Doan. All rights reserved.
//

import Foundation
import UIKit

class MovieControler {
    
    static let baseURL = URL(string: "https://api.themoviedb.org/3/search/movie?")
    
    private static let api_key = "1b706ceb3b464c20674da4f47134b66e"
    
    static func fetchMovie(searchKey: String , completion : @escaping (([Movie]?) -> Void)){
        
        guard let url = baseURL else {completion(nil); return}
        
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        
        let apiKey = URLQueryItem.init(name: "api_key", value: "\(api_key)")
        
        let searchKey = URLQueryItem.init(name: "query", value: searchKey)
        
        components?.queryItems = [apiKey,searchKey]
        
        guard let fullyURL = components?.url else {completion(nil); return}
        
        var request = URLRequest(url: fullyURL)
        request.httpMethod = "GET"
        request.httpBody = nil
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                print ("Error sending URL request :\(error.localizedDescription)")
                completion(nil)
                return
            }
            
            guard let data = data else {completion(nil); return}
            do {
                let jsonDecoder = JSONDecoder()
                
                let movieDir = try jsonDecoder.decode(Movies.self, from: data)
                let movie = movieDir.results
                completion(movie)
                return
            }
            catch {
                print("error occured", error)
            }
            
            }.resume()
    }
    
    
    static func getItemIamge(urlAsString: String, completion: @escaping ((UIImage?) -> Void)) {
        
        let imageBaseUrl = URL(string: "http://image.tmdb.org/t/p/w500")
        
        guard var imageUrl = imageBaseUrl else {completion(nil);return}
        
        imageUrl.appendPathComponent(urlAsString)
        
        print("\(imageUrl.absoluteString)")
        
        var request = URLRequest(url: imageUrl)
        request.httpMethod = "GET"
        request.httpBody = nil
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                print("Error sending network call : \(error.localizedDescription)")
            }
            guard let data = data else {completion(nil); return}
            
            let image = UIImage(data: data)
            completion(image)
        }.resume()
    }
}
