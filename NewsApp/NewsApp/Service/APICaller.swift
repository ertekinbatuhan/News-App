import Foundation

final class APICaller {
    
    static let shared = APICaller()
    
    private struct Constants {
        static let apiKey1: String = {
            guard let filePath = Bundle.main.path(forResource: "Config", ofType: "plist"),
                  let plist = NSDictionary(contentsOfFile: filePath) as? [String: Any],
                  let value = plist["NEWS_API_KEY_1"] as? String else {
                fatalError("Couldn't find key 'NEWS_API_KEY_1'")
            }
            return value
        }()
        
        static let apiKey2: String = {
            guard let filePath = Bundle.main.path(forResource: "Config", ofType: "plist"),
                  let plist = NSDictionary(contentsOfFile: filePath) as? [String: Any],
                  let value = plist["NEWS_API_KEY_2"] as? String else {
                fatalError("Couldn't find key 'NEWS_API_KEY_2'")
            }
            return value
        }()
        
        static let topHeadlinesURL = URL(string: "https://newsapi.org/v2/everything?q=us&apiKey=\(apiKey1)")
        
        static func url(for category: String, apiKey: String) -> URL? {
            return URL(string: "https://newsapi.org/v2/top-headlines?country=us&category=\(category)&apiKey=\(apiKey)")
        }
        
        static func searchURL(for query: String, apiKey: String) -> URL? {
            return URL(string: "https://newsapi.org/v2/top-headlines?apiKey=\(apiKey)&q=\(query)")
        }
    }
    
    private init() {}
    
    public func fetchStories(url: URL, completion: @escaping (Result<[News], Error>) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No data received"])))
                return
            }
            
            do {
                let result = try JSONDecoder().decode(APIResponse.self, from: data)
                print("size : \(result.articles.count)")
                completion(.success(result.articles))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    public func getTopStories(completion: @escaping (Result<[News], Error>) -> Void) {
        guard let url = Constants.topHeadlinesURL else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            return
        }
        fetchStories(url: url, completion: completion)
    }

    public func search(with query: String, completion: @escaping (Result<[News], Error>) -> Void) {
        guard !query.trimmingCharacters(in: .whitespaces).isEmpty else {
            getTopStories(completion: completion)
            return
        }
        
        guard let url = Constants.searchURL(for: query, apiKey: Constants.apiKey2) else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            return
        }
        fetchStories(url: url, completion: completion)
    }
    
    public func getCategoryStories(category: String, apiKey: String, completion: @escaping (Result<[News], Error>) -> Void) {
        guard let url = Constants.url(for: category, apiKey: apiKey) else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            return
        }
        fetchStories(url: url, completion: completion)
    }
    
    public func getEntertainmentStories(completion: @escaping (Result<[News], Error>) -> Void) {
        getCategoryStories(category: "entertainment", apiKey: Constants.apiKey2, completion: completion)
    }
    
    public func getSportsStories(completion: @escaping (Result<[News], Error>) -> Void) {
        getCategoryStories(category: "sports", apiKey: Constants.apiKey2, completion: completion)
    }
    
    public func getBusinessStories(completion: @escaping (Result<[News], Error>) -> Void) {
        getCategoryStories(category: "business", apiKey: Constants.apiKey2, completion: completion)
    }
    
    public func getGeneralStories(completion: @escaping (Result<[News], Error>) -> Void) {
        getCategoryStories(category: "general", apiKey: Constants.apiKey2, completion: completion)
    }
    
    public func getScienceStories(completion: @escaping (Result<[News], Error>) -> Void) {
        getCategoryStories(category: "science", apiKey: Constants.apiKey2, completion: completion)
    }
    
    public func getTechnologyStories(completion: @escaping (Result<[News], Error>) -> Void) {
        getCategoryStories(category: "technology", apiKey: Constants.apiKey2, completion: completion)
    }
}

