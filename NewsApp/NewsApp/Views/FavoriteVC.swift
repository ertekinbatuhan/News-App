//
//  FavoriteVC.swift
//  NewsApp
//
//  Created by Batuhan Berk Ertekin on 8.03.2024.
//

import UIKit

class FavoriteVC: UIViewController {

   
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
       title = "Favorite News"
        
    
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.separatorStyle = .none
    
    }
    

    

}



extension FavoriteVC : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favoriteCell", for: indexPath) as! FavoritesTableViewCell
        
        
        cell.newsLabel.text = "test"
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
