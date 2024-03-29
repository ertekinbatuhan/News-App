//
//  APICaller.swift
//  NewsApp
//
//  Created by Batuhan Berk Ertekin on 26.02.2024.
//

import Foundation


final class APICaller {
    
    static let shared = APICaller()
    
    struct Constants {
        static let topHeadlinesURL = URL(string:"https://newsapi.org/v2/everything?q=keyword&apiKey=15699190f7eb48d7823cacf951f5f49f")
        
      // static let searchUrlString = //"https://newsapi.org/v2/everything?from=2024-02-26&to=2024-02-26&sortBy=popularity&apiKey=15699190f7eb48d7823cacf951f5f49f&q="
        
      //  static let searchUrlString = "https://newsapi.org/v2/everything?sortBy=popularity&apiKey=15699190f7eb48d7823cacf951f5f49f&q="
        static let searchUrlString = "https://newsapi.org/v2/top-headlines?apiKey=15699190f7eb48d7823cacf951f5f49f&q="
       
    }
    
    private init() {
    }
    
    public func getTopStories(completion: @escaping(Result<[News] , Error>) -> Void ) {
        guard let url = Constants.topHeadlinesURL else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
            }else if let data = data {
                
                do {
                    let result = try JSONDecoder().decode(APIResponse.self ,from: data)
                    
                    print("size : \(result.articles.count)")
                    
                    completion(.success(result.articles))
                    
                }catch {
                    completion(.failure(error))
                    
                }
            }
        }
        task.resume()
    }
    
    
    public func search(with query : String , completion: @escaping(Result<[News] , Error>) -> Void ) {
        
        guard !query.trimmingCharacters(in: .whitespaces).isEmpty else {
            getTopStories(completion: completion)
            return
        }
        
        let urlString = Constants.searchUrlString + query
        
        guard let url = URL(string : urlString) else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
            }else if let data = data {
                
                do {
                    let result = try JSONDecoder().decode(APIResponse.self ,from: data)
                    
                    print("size : \(result.articles.count)")
                    
                    completion(.success(result.articles))
                    
                }catch {
                    completion(.failure(error))
                        
                }
            }
        }
        task.resume()
    }
}
    
    
