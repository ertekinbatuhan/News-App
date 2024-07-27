//
//  FavoriteVCViewModel.swift
//  NewsApp
//
//  Created by Batuhan Berk Ertekin on 12.03.2024.
//

import Foundation
import RxSwift
import Firebase

class FavoriteViewModel {
    
    let db = Firestore.firestore()
    var newsItemsArray = BehaviorSubject<[FavoriteNews]>(value: [FavoriteNews]())
    var favoriteDaoRepository = FavoriteDaoRepository()
    
    init() {
        
        newsItemsArray = favoriteDaoRepository.newsItemsArray
        loadFavoriteNews()
        
    }
    
    func loadFavoriteNews() {
        favoriteDaoRepository.loadNews()
    }
    
    func deleteNews(newsItem: FavoriteNews, completion: @escaping (Error?) -> Void) {
            let newsCollection = db.collection("News")
            let query = newsCollection.whereField("title", isEqualTo: newsItem.title)

            query.getDocuments { (snapshot, error) in
                if let error = error {
                    completion(error)
                    return
                }

                guard let documents = snapshot?.documents else {
                    completion(NSError(domain: "", code: 404, userInfo: [NSLocalizedDescriptionKey: "No documents found"]))
                    return
                }

                for document in documents {
                    newsCollection.document(document.documentID).delete { error in
                        if let error = error {
                            completion(error)
                        } else {
                            completion(nil)
                        }
                    }
                }
            }
        }
}
