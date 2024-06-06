import Foundation

final class APICaller {
    
    static let shared = APICaller()
    
    private struct Constants {
        static let apiKey1: String = {
            guard let filePath = Bundle.main.path(forResource: "Config", ofType: "plist"),
                  let plist = NSDictionary(contentsOfFile: filePath) as? [String: Any],
                  let value = plist["NEWS_API_KEY_1"] as? String else {
                fatalError("Couldn't find key news api key 1")
            }
            return value
        }()
        
        static let apiKey2: String = {
            guard let filePath = Bundle.main.path(forResource: "Config", ofType: "plist"),
                  let plist = NSDictionary(contentsOfFile: filePath) as? [String: Any],
                  let value = plist["NEWS_API_KEY_2"] as? String else {
                fatalError("Couldn't find key 'news api key 2")
            }
            return value
        }()
        
        static let topHeadlinesURL = URL(string: "https://newsapi.org/v2/everything?q=us&apiKey=\(apiKey1)")
        static let entertainmentURL = URL(string: "https://newsapi.org/v2/top-headlines?country=us&category=entertainment&apiKey=\(apiKey2)")
        static let sportsURL = URL(string: "https://newsapi.org/v2/top-headlines?country=us&category=sports&apiKey=\(apiKey2)")
        static let generalURL = URL(string: "https://newsapi.org/v2/top-headlines?country=us&category=general&apiKey=\(apiKey2)")
        static let scienceURL = URL(string: "https://newsapi.org/v2/top-headlines?country=us&category=science&apiKey=\(apiKey2)")
        static let technologyURL = URL(string: "https://newsapi.org/v2/top-headlines?country=us&category=technology&apiKey=\(apiKey2)")
        static let businessURL = URL(string: "https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=\(apiKey2)")
        static let searchUrlString = "https://newsapi.org/v2/top-headlines?apiKey=\(apiKey2)&q="
    }
    
    private init() {}
    
    public func getTopStories(completion: @escaping (Result<[News], Error>) -> Void) {
        guard let url = Constants.topHeadlinesURL else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
            } else if let data = data {
                do {
                    let result = try JSONDecoder().decode(APIResponse.self, from: data)
                    print("size : \(result.articles.count)")
                    completion(.success(result.articles))
                } catch {
                    completion(.failure(error))
                }
            }
        }
        task.resume()
    }

    public func search(with query: String, completion: @escaping (Result<[News], Error>) -> Void) {
        guard !query.trimmingCharacters(in: .whitespaces).isEmpty else {
            getTopStories(completion: completion)
            return
        }
        
        let urlString = Constants.searchUrlString + query
        
        guard let url = URL(string: urlString) else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
            } else if let data = data {
                do {
                    let result = try JSONDecoder().decode(APIResponse.self, from: data)
                    print("size : \(result.articles.count)")
                    completion(.success(result.articles))
                } catch {
                    completion(.failure(error))
                }
            }
        }
        task.resume()
    }
    
    public func getEntertainmentStories(completion: @escaping (Result<[News], Error>) -> Void) {
        guard let url = Constants.entertainmentURL else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
            } else if let data = data {
                do {
                    let result = try JSONDecoder().decode(APIResponse.self, from: data)
                    print("size : \(result.articles.count)")
                    completion(.success(result.articles))
                } catch {
                    completion(.failure(error))
                }
            }
        }
        task.resume()
    }
    
    public func getSportsStories(completion: @escaping (Result<[News], Error>) -> Void) {
        guard let url = Constants.sportsURL else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
            } else if let data = data {
                do {
                    let result = try JSONDecoder().decode(APIResponse.self, from: data)
                    print("size : \(result.articles.count)")
                    completion(.success(result.articles))
                } catch {
                    completion(.failure(error))
                }
            }
        }
        task.resume()
    }
    
    public func getBusinessStories(completion: @escaping (Result<[News], Error>) -> Void) {
        guard let url = Constants.businessURL else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
            } else if let data = data {
                do {
                    let result = try JSONDecoder().decode(APIResponse.self, from: data)
                    print("size : \(result.articles.count)")
                    completion(.success(result.articles))
                } catch {
                    completion(.failure(error))
                }
            }
        }
        task.resume()
    }
    
    public func getGeneralStrories(completion: @escaping (Result<[News], Error>) -> Void) {
        guard let url = Constants.generalURL else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
            } else if let data = data {
                do {
                    let result = try JSONDecoder().decode(APIResponse.self, from: data)
                    print("size : \(result.articles.count)")
                    completion(.success(result.articles))
                } catch {
                    completion(.failure(error))
                }
            }
        }
        task.resume()
    }
    
    public func getScienceStories(completion: @escaping (Result<[News], Error>) -> Void) {
        guard let url = Constants.scienceURL else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
            } else if let data = data {
                do {
                    let result = try JSONDecoder().decode(APIResponse.self, from: data)
                    print("size : \(result.articles.count)")
                    completion(.success(result.articles))
                } catch {
                    completion(.failure(error))
                }
            }
        }
        task.resume()
    }
    
    public func getTechnologyStories(completion: @escaping (Result<[News], Error>) -> Void) {
        guard let url = Constants.technologyURL else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
            } else if let data = data {
                do {
                    let result = try JSONDecoder().decode(APIResponse.self, from: data)
                    print("size : \(result.articles.count)")
                    completion(.success(result.articles))
                } catch {
                    completion(.failure(error))
                }
            }
        }
        task.resume()
    }
}

