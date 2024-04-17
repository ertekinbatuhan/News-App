//
//  CategoryDao.swift
//  NewsApp
//
//  Created by Batuhan Berk Ertekin on 17.04.2024.
//

import Foundation

class CategoryDao {
    
    let db : FMDatabase?
    
    init() {
      
        let targetWay = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        
        let databaseUrl = URL(fileURLWithPath: targetWay).appendingPathComponent("news.sqlite")
        
        db = FMDatabase(path: databaseUrl.path)
    }
    
    func allCategory() -> [Category] {
        
        var categoryList = [Category]()
        
        db?.open()
        
        do {
            
            let rs = try db!.executeQuery("SELECT * FROM category", values: nil)
            
            while rs.next(){
                
                let category = Category(category_id: Int(rs.string(forColumn: "category_id"))!, category_name: rs.string(forColumn: "catagory_name")!, category_image: rs.string(forColumn: "category_image")!)
                
                categoryList.append(category)
            }
        } catch {
            print(error.localizedDescription)
        }
        
        
        db?.close()
        
        return categoryList
    }
}
