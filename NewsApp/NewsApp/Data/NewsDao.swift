//
//  NewsDao.swift
//  NewsApp
//
//  Created by Batuhan Berk Ertekin on 17.04.2024.
//

import Foundation

class NewsDao {
    
    let db : FMDatabase?
    
    init() {
      
        let targetWay = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        
        let databaseUrl = URL(fileURLWithPath: targetWay).appendingPathComponent("news.sqlite")
        
        db = FMDatabase(path: databaseUrl.path)
    }
    
    func selectedNews(category_id : Int) -> [NewsSQLite] {
        
        var list = [NewsSQLite]()
        
        db?.open()
        
        do {
            
            let rs = try db!.executeQuery("SELECT * FROM category,news WHERE news.category_id = category.category_id and news.category_id = ?" , values: [category_id])
            
            while rs.next(){
                
                let category = Category(category_id: Int(rs.string(forColumn: "category_id"))!, category_name: rs.string(forColumn: "catagory_name")!, category_image: rs.string(forColumn: "category_image")!)
                
                let news = NewsSQLite(news_name: rs.string(forColumn: "news_name")!,news_title: rs.string(forColumn: "news_title")!, news_image: rs.string(forColumn: "news_image")!,category_id: category)
                
                list.append(news)
            }
        } catch {
            print(error.localizedDescription)
        }
        
        
        db?.close()
        
        return list
    }
}
