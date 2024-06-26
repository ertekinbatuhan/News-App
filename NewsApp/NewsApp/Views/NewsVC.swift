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
        
        newsViewModel.reloadTableView = { [weak self] in
                  DispatchQueue.main.async {
                      self?.tableView.reloadData()
                  }
              }
              
              newsViewModel.showError = { error in
                  print(error)
              }
              
              newsViewModel.fetchTopStories()
        
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
       // return viewModels.count
        return newsViewModel.viewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
       guard  let cell = tableView.dequeueReusableCell(withIdentifier: NewsTableViewCell.identifier, for: indexPath) as? NewsTableViewCell else {
            fatalError()
        }
        
        cell.configure(with: newsViewModel.viewModels[indexPath.row])
        
    
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let article = newsViewModel.news[indexPath.row]
        
        
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
            
            let articlesIndex = self.newsViewModel.news[indexPath.row]
            
            self.newsViewModel.addNewsToFirebase(articlesIndex: articlesIndex)
           
        }
        addAction.backgroundColor = .systemGreen
                                    
            return UISwipeActionsConfiguration(actions: [addAction])
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
           
            newsViewModel.fetchTopStories()
            
          
        } else {
            newsViewModel.searchNews(with: searchText)
        }
    }


    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text, !text.isEmpty else {
            return
        }
        
        newsViewModel.searchNews(with: text)
  
    }

}

