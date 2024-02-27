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
        static let topHeadlinesURL = URL(string:"https://newsapi.org/v2/top-headlines?country=us&apiKey=15699190f7eb48d7823cacf951f5f49f")
        
        static let searchUrlString = "https://newsapi.org/v2/everything?from=2024-02-26&to=2024-02-26&sortBy=popularity&apiKey=15699190f7eb48d7823cacf951f5f49f&q="
    }
    
    private init() {
    }
    
    
    
    
    
    
    public func getTopStories(completion: @escaping(Result<[Article] , Error>) -> Void ) {
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
    
    
    public func search(with query : String , completion: @escaping(Result<[Article] , Error>) -> Void ) {
        
        guard !query.trimmingCharacters(in: .whitespaces).isEmpty else {
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
    
    struct APIResponse : Codable {
        let articles : [Article]
        
    }
    
    struct Article : Codable{
        let source : Source
        let title : String
        let description : String?
        let url : String?
        let urlToImage : String?
        let publishedAt : String
        
    }
    
    struct  Source : Codable {
        let name : String
        
    }


