//
//  NewsViewModel.swift
//  NewsApp
//
//  Created by Admin on 9/11/19.
//  Copyright © 2019 Farooq. All rights reserved.
//

import Foundation
import UIKit

class NewsViewModel{
    
    // MARK: Properties
    private var news: NewsModel?
    private let loader = Loader()
    private var savedHeadlines: [Headlines]?
    
    func fetchNewsHeadlines(completion:(() -> Void)?){
        let url: String = "\(EndPoints.TopHeadline.path)\(EndPoints.Country.path)\(APIKey.ApiKey.rawValue)"
        print(url)
        if NetworkConnection.isConnectedToNetwork(){
            loader.show()
            Network.shared.fetchNewsHeadlines(urlByName: url,type: NewsModel.self) {[weak self] (response,success,error) in
                if let responseData = response{
                    self?.news = responseData
                    self?.loader.hide()
                    self?.deleteAllSavedHeadlines()
                    self?.saveHeadlinesToLocalDB()
                    completion?()
                }else if let error = error {
                    self?.loader.hide()
                    print(error)
                }
            }
        }else{
            self.fetchSavedHeadlines()
            completion?()
        }
    }
    
    // MARK: - To save data to local DB
    public func saveHeadlinesToLocalDB(){
        news.map ({let news = $0
            _ = news.articles.map ({let headline = $0
                print(headline)
                DatastoreManager.shared?.saveHeadline(title: headline.title ?? "" , description: headline.description ?? "", author: headline.author ?? "", date:headline.publishedAt ?? "", poster: headline.urlToImage ?? "")
            })
        })
    }
    
    public func fetchSavedHeadlines(index: Int) -> Headlines?{
        guard let savedHeadline = savedHeadlines?[index] else { return nil }
        return savedHeadline
    }
    
    public func fetchSavedHeadlines(){
        //fetch all the saved data
        savedHeadlines = DatastoreManager.shared?.fetchAllSavedHeadlines()
    }
    
    public func deleteAllSavedHeadlines(){
        DatastoreManager.shared?.deleteAllSavedHeadlines()
    }
    
    // MARK: - To add loaders
    public func showLoader(windowView: UIView){
        windowView.addSubview(loader)
        loader.hide()
    }
    
    // MARK: - To send each cell data using index
    public func getCellViewModel(index: Int) -> NewsTableViewCellModel? {
        guard let news = news else { return nil }
        let newsTableViewCellModel = NewsTableViewCellModel(news: (news.articles[index]))
        return newsTableViewCellModel
    }
    
    // MARK: - Number of movies to be shown
    public var count: Int {
        if NetworkConnection.isConnectedToNetwork(){
            return news?.articles.count ?? 0
        }else{
            return savedHeadlines?.count ?? 0
        }
    }
}
