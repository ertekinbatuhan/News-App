//
//  FavoriteVCViewModel.swift
//  NewsApp
//
//  Created by Batuhan Berk Ertekin on 12.03.2024.
//

import Foundation
import RxSwift


class FavoriteViewModel {
    
    var newsItemsArray = BehaviorSubject<[FavoriteNews]>(value: [FavoriteNews]())
    var favoriteDaoRepository = FavoriteDaoRepository()
    
    init() {
        
        newsItemsArray = favoriteDaoRepository.newsItemsArray
        loadFavoriteNews()
        
    }
    
    func loadFavoriteNews() {
        favoriteDaoRepository.loadNews()
    }
}
