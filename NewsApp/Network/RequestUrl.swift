//
//  RequestUrl.swift
//  NewsApp
//
//  Created by Admin on 9/11/19.
//  Copyright © 2019 Farooq. All rights reserved.
//

import Foundation

enum APIKey: String {
    case ApiKey = "&apiKey=581031ba8eb84e5b9da7cdb4af5a232d"
}

enum EndPoints {
    case TopHeadline
    case Country
}

extension EndPoints {
    var path:String {
        let baseURL = "https://newsapi.org/v2/"
        struct Section {
            static let topHeadline = "top-headlines?"
            static let country = "country=us"
        }
        switch(self) {
        case .TopHeadline:
            return "\(baseURL)\(Section.topHeadline)"
        case .Country:
            return "\(Section.country)"
            
        }
    }
}
