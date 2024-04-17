//
//  TestSegueViewController.swift
//  NewsApp
//
//  Created by Batuhan Berk Ertekin on 17.04.2024.
//

import UIKit

class NewsSqlVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    
    var category : Category?
    var newsList = [NewsSQLite]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        tableView.dataSource  = self
        tableView.delegate = self
        
        if let getCategory = category {
            navigationItem.title = getCategory.category_name
            
            newsList = NewsDao().selectedNews(category_id: getCategory.category_id)
            
        }
    }
    
}

extension NewsSqlVC : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return newsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "toNews", for: indexPath) as! NewsSqlCell
        
        
        let getIndexPath = newsList[indexPath.row]
        
        cell.newsTitle.text =  getIndexPath.news_title
        cell.newsName.text = getIndexPath.news_name
        cell.newsImageView.image = UIImage(named: getIndexPath.news_image!)
        
        cell.backgroundColor = UIColor(white: 0.95, alpha: 1)
        cell.backGView.layer.cornerRadius = 10.0
        cell.selectionStyle = .none
        
        cell.newsImageView.layer.cornerRadius = 10.0
        cell.newsImageView.layer.masksToBounds = true
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    
}
