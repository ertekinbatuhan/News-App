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
    var news = [News]()
    var viewModels = [NewsTableViewCellViewModel]()
    
    var reloadTableView: (() -> Void)?
    var showError: ((Error) -> Void)?

    func addNewsToFirebase(articlesIndex : News) {
        
    newsDaoRepository.addNewsToFirebase(articlesIndex: articlesIndex)
        
    }
    
    func fetchTopStories() {
        APICaller.shared.getTopStories { [weak self] result in
            switch result {
            case .success(let articles):
                self?.news = articles
                
                self?.viewModels = articles.compactMap({
                    NewsTableViewCellViewModel(title: $0.title, subTitle: $0.description ?? "", imageURL: URL(string: $0.urlToImage ?? ""))
                })
                self?.reloadTableView?()
            case .failure(let error):
                self?.showError?(error)
            }
        }
    }
    
    func searchNews(with query: String) {
            APICaller.shared.search(with: query) { [weak self] result in
                switch result {
                case .success(let articles):
                    self?.news = articles
                    
                    self?.viewModels = articles.compactMap({
                        NewsTableViewCellViewModel(title: $0.title, subTitle: $0.description ?? "", imageURL: URL(string: $0.urlToImage ?? ""))
                    })
                    self?.reloadTableView?()
                case .failure(let error):
                    self?.showError?(error)
                }
            }
        }
}
