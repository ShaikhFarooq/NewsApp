//
//  News.swift
//  NewsApp
//
//  Created by Admin on 9/11/19.
//  Copyright © 2019 Farooq. All rights reserved.
//

import Foundation

// MARK: - News
struct NewsModel: Codable{
    var articles: [Articles]
}

struct Articles: Codable {
    var title: String?
    var description: String?
    var urlToImage: String?
    var author: String?
    var publishedAt: String?
}
