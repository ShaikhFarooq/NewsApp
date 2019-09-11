//
//  NewsViewModel.swift
//  NewsApp
//
//  Created by Admin on 9/11/19.
//  Copyright © 2019 Farooq. All rights reserved.
//

import Foundation

class NewsViewModel{
    
    // MARK: Properties

    private var news: NewsModel?

    func fetchNewsHeadlines(completion:(() -> Void)?){
        let url: String = "\(EndPoints.TopHeadline.path)\(EndPoints.Country.path)\(APIKey.ApiKey.rawValue)"
        print(url)
        Network.shared.fetchNewsHeadlines(urlByName: url,type: NewsModel.self) {[weak self] (response,success,error) in
            print(response)
            if let responseData = response{
                self?.news = responseData
                completion?()
            }else if let error = error {
                print(error)
            }
            
        }
    }
}
