//
//  NewsDaoRepository.swift
//  NewsApp
//
//  Created by Batuhan Berk Ertekin on 12.03.2024.
//

import Foundation
import Firebase

class NewsDaoRepository {
    
    func addNewsToFirebase(articlesIndex : News) {
        
        let db = Firestore.firestore()
        
        let fireStoreNewsData  = ["source" : articlesIndex.source.name,"title": articlesIndex.title, "description": articlesIndex.description!, "url": articlesIndex.url!, "urlToImage": articlesIndex.urlToImage ?? "null", "Date":FieldValue.serverTimestamp()] as [String : Any]
        
        db.collection("News").addDocument(data: fireStoreNewsData , completion: { error in
            
            if error != nil {
                
                print(error?.localizedDescription)
            } else {
                
            }
            
        })
    }
}
