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
    
        // Tr aktif şuan
        static let topHeadlinesURL = URL(string:"https://newsapi.org/v2/everything?q=tr&apiKey=15699190f7eb48d7823cacf951f5f49f")
         
        static let entartainmentsURL = URL(string:"https://newsapi.org/v2/top-headlines?country=us&category=entertainment&apiKey=5d50a413e0b544ee99f6c97adea92e80")
        
        static let sportsURL = URL(string: "https://newsapi.org/v2/top-headlines?country=us&category=sports&apiKey=5d50a413e0b544ee99f6c97adea92e80")
        
        static let generalURL = URL(string: "https://newsapi.org/v2/top-headlines?country=us&category=general&apiKey=5d50a413e0b544ee99f6c97adea92e80")
        
        static let scienceURL = URL(string:"https://newsapi.org/v2/top-headlines?country=us&category=science&apiKey=5d50a413e0b544ee99f6c97adea92e80")
        
        static let technologyURL = URL(string: "https://newsapi.org/v2/top-headlines?country=us&category=technology&apiKey=5d50a413e0b544ee99f6c97adea92e80")
        
        static let businessURL = URL(string: "https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=5d50a413e0b544ee99f6c97adea92e80")
        
    
        static let searchUrlString = "https://newsapi.org/v2/top-headlines?apiKey=5d50a413e0b544ee99f6c97adea92e80&q="
       
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
    
    public func getEntertainmentStories(completion: @escaping(Result<[News] , Error>) -> Void ) {
        guard let url = Constants.entartainmentsURL else {
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
    
    public func getSportsStories(completion: @escaping(Result<[News] , Error>) -> Void ) {
        guard let url = Constants.sportsURL else {
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
    
    public func getBusinessStories(completion: @escaping(Result<[News] , Error>) -> Void ) {
        guard let url = Constants.businessURL else {
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
    
    public func getGeneralStrories(completion: @escaping(Result<[News] , Error>) -> Void ) {
        guard let url = Constants.generalURL else {
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
    
    public func getScienceStories(completion: @escaping(Result<[News] , Error>) -> Void ) {
        guard let url = Constants.scienceURL else {
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
    
    public func getTechnologyStories(completion: @escaping(Result<[News] , Error>) -> Void ) {
        guard let url = Constants.technologyURL else {
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
    
    
