//
//  ViewController.swift
//  NewsApp
//
//  Created by Batuhan Berk Ertekin on 26.02.2024.
//

import UIKit
import SafariServices
import Firebase

class NewsVC: UIViewController , UITableViewDelegate , UITableViewDataSource , UISearchBarDelegate{
    
    let db = Firestore.firestore()
        
    private let tableView : UITableView = {
        let table = UITableView()
        table.register(NewsTableViewCell.self, forCellReuseIdentifier: NewsTableViewCell.identifier)
        return table
    }()
    
    private let searchViewController = UISearchController(searchResultsController: nil)
    
    private var viewModels = [NewsTableViewCellViewModel]()
    private var news = [News]()
    private var newsDaoRepository = NewsDaoRepository()
    private var newsViewModel = NewsViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
      
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        
        ThemeManager.shared.updateTheme()
        
        createSearchBar()
        
        APICaller.shared.getTopStories{ [weak self]  result in
            switch result {
            case .success(let articles):
                self?.news = articles
                self?.viewModels = articles.compactMap({
                    NewsTableViewCellViewModel(title: $0.title, subTitle: $0.description ?? "", imageURL: URL(string: $0.urlToImage ?? ""))
                })
                
                DispatchQueue.main.async {
                    
                    self?.tableView.reloadData()
                }
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func createSearchBar() {
        navigationItem.searchController = searchViewController
        searchViewController.searchBar.delegate = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
       guard  let cell = tableView.dequeueReusableCell(withIdentifier: NewsTableViewCell.identifier, for: indexPath) as? NewsTableViewCell else {
            fatalError()
        }
        
        cell.configure(with: viewModels[indexPath.row])
        
    
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let article = news[indexPath.row]
        
        
        guard let url =  URL(string : article.url ?? "") else {
            return
        }
        
        let viewController  = SFSafariViewController(url: url)
        present(viewController,animated : true )
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let addAction = UIContextualAction(style: .normal, title: "Add Favorites") {(contextualAction , view , boolValue) in
            
            let articlesIndex = self.news[indexPath.row]
            
            self.newsViewModel.addNewsToFirebase(articlesIndex: articlesIndex)
           
        }
        addAction.backgroundColor = .systemGreen
                                    
            return UISwipeActionsConfiguration(actions: [addAction])
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
           
            loadTopStories()
        }
    }

    func loadTopStories() {
        APICaller.shared.getTopStories { [weak self] result in
            switch result {
            case .success(let articles):
                self?.news = articles
                self?.viewModels = articles.compactMap({
                    NewsTableViewCellViewModel(title: $0.title, subTitle: $0.description ?? "", imageURL: URL(string: $0.urlToImage ?? ""))
                })
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text, !text.isEmpty else {
            return
        }
        
        APICaller.shared.search(with: text) { [weak self] result in
            switch result {
            case .success(let articles):
                self?.news = articles
                self?.viewModels = articles.compactMap({
                    NewsTableViewCellViewModel(title: $0.title, subTitle: $0.description ?? "", imageURL: URL(string: $0.urlToImage ?? ""))
                })
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                    self?.searchViewController.dismiss(animated: true)
                }
            case .failure(let error):
                print(error)
            }
        }
    }

}

