//
//  NewsSQLite.swift
//  NewsApp
//
//  Created by Batuhan Berk Ertekin on 17.04.2024.
//

import Foundation

struct NewsSQLite {
    var news_name : String?
    var news_title : String?
    var news_image : String?
    var category_id : Category?
    
    
    init(news_name: String? = nil, news_title: String? = nil, news_image: String? = nil, category_id: Category? = nil) {
        self.news_name = news_name
        self.news_title = news_title
        self.news_image = news_image
        self.category_id = category_id
    }
}
