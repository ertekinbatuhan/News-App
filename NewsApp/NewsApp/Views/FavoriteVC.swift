//
//  FavoriteVC.swift
//  NewsApp
//
//  Created by Batuhan Berk Ertekin on 8.03.2024.
//

import UIKit
import Firebase
import SafariServices

class FavoriteVC: UIViewController {
        
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    let db = Firestore.firestore()
    var isSearching = false
    var searchArray = [FavoriteNews]()
    
    var newsItems = [FavoriteNews]()
    var favoriteViewModel = FavoriteViewModel()
   
    override func viewDidLoad() {
        super.viewDidLoad()
       
        ThemeManager.shared.updateTheme()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        searchBar.delegate = self
        
        _ = favoriteViewModel.newsItemsArray.subscribe(onNext: { data in
            
            self.newsItems = data
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        })
    }
}

extension FavoriteVC : UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        
        if searchText == "" {
            isSearching = false
            
        } else {
            isSearching = true
            searchArray = newsItems.filter({$0.title.lowercased().contains(searchText.lowercased())})
        }
        self.tableView.reloadData()
    }
    
}

extension FavoriteVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        if isSearching {
            
            return  searchArray.count
            
        } else {
            return newsItems.count
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let news = newsItems[indexPath.row]
        
        
        guard let url =  URL(string : news.url ?? "") else {
            return
        }
        
        let viewController  = SFSafariViewController(url: url)
        present(viewController,animated : true )
        
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .normal, title: "Delete") { [weak self] (contextualAction, view, boolValue) in
            guard let self = self else { return }
            
            let selectedNews = self.isSearching ? self.searchArray[indexPath.row] : self.newsItems[indexPath.row]
            self.deleteNewsFromFirestore(newsItem: selectedNews)
        }
        
        deleteAction.backgroundColor = .red
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }

    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let shareUrlAction = UIContextualAction(style: .normal, title: "Share URL") { [weak self] (contextualAction, view, boolValue) in
            guard let self = self else { return }

            let selectedNews = self.isSearching ? self.searchArray[indexPath.row] : self.newsItems[indexPath.row]
            let url = selectedNews.url

            let activityViewController = UIActivityViewController(activityItems: [url!], applicationActivities: nil)
            if let popoverController = activityViewController.popoverPresentationController {
                popoverController.sourceView = view
            }
            self.present(activityViewController, animated: true, completion: nil)
        }

        shareUrlAction.backgroundColor = .systemBlue

        return UISwipeActionsConfiguration(actions: [shareUrlAction])
    }


    func deleteNewsFromFirestore(newsItem: FavoriteNews) {
           favoriteViewModel.deleteNews(newsItem: newsItem) { [weak self] error in
               if let error = error {
                   print("Error deleting document: \(error)")
                   return
               }
               
               if self?.isSearching == true {
                   self?.searchArray.removeAll { $0.title == newsItem.title }
               } else {
                   self?.newsItems.removeAll { $0.title == newsItem.title }
               }
               
               DispatchQueue.main.async {
                   self?.tableView.reloadData()
               }
           }
       }
       

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favoriteCell", for: indexPath) as! FavoritesTableViewCell
        
        let newsItem = newsItems[indexPath.row]
        cell.newsLabel.text = newsItem.title
        cell.descriptionLabel.text = newsItem.description
        ThemeManager.shared.updateContentViewBackgroundColor(cell.settingsBackgroundView)
       
       
        if let url = URL(string: newsItem.imageUrl) {
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let error = error {
                    print("Error loading image: \(error)")
                    return
                }
                
                if let data = data, let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        cell.newsImageView.image = image
                    }
                }
            }
            task.resume()
        }
        
        if isSearching {
            let newsItem = searchArray[indexPath.row]
            cell.newsLabel.text = newsItem.title
            cell.descriptionLabel.text = newsItem.description
            
            if let url = URL(string: newsItem.imageUrl) {
                let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                    if let error = error {
                        print("Error loading image: \(error)")
                        return
                    }
                    
                    if let data = data, let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            cell.newsImageView.image = image
                        }
                    }
                }
                task.resume()
            }
        } else {
            let newsItem = newsItems[indexPath.row]
            cell.newsLabel.text = newsItem.title
            cell.descriptionLabel.text = newsItem.description
            
            if let url = URL(string: newsItem.imageUrl) {
                let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                    if let error = error {
                        print("Error loading image: \(error)")
                        return
                    }
                    
                    if let data = data, let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            cell.newsImageView.image = image
                        }
                    }
                }
                task.resume()
            }
        }

        cell.backgroundColor = UIColor(white: 0.95, alpha: 1)
        cell.designView.layer.cornerRadius = 10.0
        cell.selectionStyle = .none
        
        cell.newsImageView.layer.cornerRadius = 10.0
        cell.newsImageView.layer.masksToBounds = true
    
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return  300
    }
    
}
