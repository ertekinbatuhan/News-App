//
//  NewsViewModel.swift
//  NewsApp
//
//  Created by Batuhan Berk Ertekin on 12.03.2024.
//

import Foundation
import Firebase
import RxSwift

class NewsViewModel {
    
    var newsDaoRepository = NewsDaoRepository()
    
    func addNewsToFirebase(articlesIndex : News) {
        
    newsDaoRepository.addNewsToFirebase(articlesIndex: articlesIndex)
        
    }
    
    
    
}
