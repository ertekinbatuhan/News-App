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
    
    var newsTitleArray = [String]()
    var newsUrlImageArray = [String]()
   
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
                
                self.newsTitleArray.removeAll()
                self.newsUrlImageArray.removeAll() // Mevcut veriyi temizle

                for document in snapshots!.documents {
                    if let newsTitle = document.get("title") as? String {
                        self.newsTitleArray.append(newsTitle)
                    
                    }
                    
                    if let newsUrl = document.get("urlToImage") as? String {
                        self.newsUrlImageArray.append(newsUrl)
                        
                        print(self.newsUrlImageArray)
                    }
                }
            }

            self.tableView.reloadData()
        }

        }
    }

extension FavoriteVC : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsTitleArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favoriteCell", for: indexPath) as! FavoritesTableViewCell
        
        
        cell.newsLabel.text = newsTitleArray[indexPath.row]
        cell.newsImageView.image = UIImage(named: "news")
        
        
        cell.backgroundColor = UIColor(white: 0.95, alpha: 1)
        cell.designView.layer.cornerRadius = 10.0
        cell.selectionStyle = .none
        
        return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
}
