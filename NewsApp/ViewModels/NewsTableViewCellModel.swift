//
//  NewsTableViewCellModel.swift
//  NewsApp
//
//  Created by Admin on 9/11/19.
//  Copyright © 2019 Farooq. All rights reserved.
//

import Foundation

class NewsTableViewCellModel {
    
    private let news: Articles
    
    init(news: Articles) {
        self.news = news
    }
    
    var title: String {
        return news.title ?? "N/A"
    }
    
    var publishedAt : String {
        return news.publishedAt ?? "N/A"
    }
    
    var urlToImage: String {
        return news.urlToImage ?? "N/A"
    }
   
    var author: String {
        return news.author ?? "N/A"
    }
    
    var description: String {
        return news.description ?? "N/A"
    }
}
