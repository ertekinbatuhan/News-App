//
//  CategoryViewModel.swift
//  NewsApp
//
//  Created by Batuhan Berk Ertekin on 21.04.2024.
//

import Foundation

class CategoryViewModel {
    
    func databaseCopy(){
        
        let bundleWay = Bundle.main.path(forResource: "news", ofType: ".sqlite")
        
        let targetWay = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        
        let fileManager = FileManager.default
        
        let copyLocation = URL(fileURLWithPath: targetWay).appendingPathComponent("news.sqlite")
        
        if fileManager.fileExists(atPath: copyLocation.path) {
            print("the database already exists")
        }else{
            do {
                
                try fileManager.copyItem(atPath: bundleWay!, toPath: copyLocation.path)
                
            }catch{
                print(error)
            }
        }
    }
}
