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
   
    override func viewDidLoad() {
        super.viewDidLoad()
       
        title = "Favorite News"
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        searchBar.delegate = self
      
        db.collection("News").addSnapshotListener { snapshots, error in
            if let error = error {
                print(error.localizedDescription)
                return
            } else {
                
                self.newsItems.removeAll()

                for document in snapshots!.documents {
                    if let newsTitle = document.get("title") as? String,
                       let newsToUrl = document.get("url") as? String ,
                       let newsUrl = document.get("urlToImage") as? String {
                        let newsItem = FavoriteNews(title: newsTitle, imageUrl: newsUrl, url: newsToUrl)
                        self.newsItems.append(newsItem)
                    }
                  
                }
            }

            self.tableView.reloadData()
        }
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

            if self.isSearching {
                self.searchArray.remove(at: indexPath.row)
            } else {
                self.newsItems.remove(at: indexPath.row)
            }

            tableView.deleteRows(at: [indexPath], with: .fade)
        }

        deleteAction.backgroundColor = .red

        return UISwipeActionsConfiguration(actions: [deleteAction])
    }

    func deleteNewsFromFirestore(newsItem: FavoriteNews) {
       
        let newsCollection = db.collection("News")
        let query = newsCollection.whereField("title", isEqualTo: newsItem.title)

        query.getDocuments { (snapshot, error) in
            if let error = error {
                print("Error getting documents: \(error)")
                return
            }

            guard let documents = snapshot?.documents else {
                print("No documents found")
                return
            }

            for document in documents {
                newsCollection.document(document.documentID).delete { error in
                    if let error = error {
                        print("Error deleting document: \(error)")
                    } else {
                        print("Document successfully deleted")
                    }
                }
            }
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favoriteCell", for: indexPath) as! FavoritesTableViewCell
        
        let newsItem = newsItems[indexPath.row]
        cell.newsLabel.text = newsItem.title
        
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
        return  250
    }
    
}
