//
//  FavoriteVC.swift
//  NewsApp
//
//  Created by Batuhan Berk Ertekin on 8.03.2024.
//

import UIKit
import Firebase


class FavoriteVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    let db = Firestore.firestore()
    
    var newsItems = [FavoriteNews]()
   
    override func viewDidLoad() {
        super.viewDidLoad()
       
       title = "Favorite News"
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        
        
        db.collection("News").addSnapshotListener { snapshots, error in
            if let error = error {
                print(error.localizedDescription)
                return
            } else {
                
                self.newsItems.removeAll() 

                for document in snapshots!.documents {
                    if let newsTitle = document.get("title") as? String,
                       let newsUrl = document.get("urlToImage") as? String {
                        let newsItem = FavoriteNews(title: newsTitle, imageUrl: newsUrl)
                        self.newsItems.append(newsItem)
                    }
                }
            }

            self.tableView.reloadData()
        }
    }
}

extension FavoriteVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsItems.count
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

        cell.backgroundColor = UIColor(white: 0.95, alpha: 1)
        cell.designView.layer.cornerRadius = 10.0
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}

