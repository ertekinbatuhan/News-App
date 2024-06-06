//
//  FavoriteDaoRepository.swift
//  NewsApp
//
//  Created by Batuhan Berk Ertekin on 12.03.2024.
//

import Foundation
import Firebase
import RxSwift

class FavoriteDaoRepository {
    
    var newsItemsArray = BehaviorSubject<[FavoriteNews]>(value: [FavoriteNews]())
    
    func loadNews() {
        
        let db = Firestore.firestore()
        
        db.collection("News").addSnapshotListener { snapshots, error in
            if let error = error {
                print(error.localizedDescription)
                return
            } else {
                
                
                var favoriteNews = [FavoriteNews]()
                
                for document in snapshots!.documents {
                    if let newsTitle = document.get("title") as? String,
                       let newsToUrl = document.get("url") as? String ,
                       let newsDescription = document.get("description") as? String,
                       let newsUrl = document.get("urlToImage") as? String {
                        let newsItem = FavoriteNews(title: newsTitle, imageUrl: newsUrl, url: newsToUrl, description: newsDescription)
                        
                        favoriteNews.append(newsItem)
                    
                    }
                }
                
                self.newsItemsArray.onNext(favoriteNews)
            }
        }
    }
}
