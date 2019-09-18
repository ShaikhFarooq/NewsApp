//
//  HeadlineDetailsViewController.swift
//  NewsApp
//
//  Created by Admin on 9/12/19.
//  Copyright © 2019 Farooq. All rights reserved.
//

import UIKit

class HeadlineDetailsViewController: UIViewController {
    
    // MARK: IBOutlets
    @IBOutlet weak var headlinePosterImgView: UIImageView!
    @IBOutlet weak var headlineTitleLbl: UILabel!
    @IBOutlet weak var headlineAuthorLbl: UILabel!
    @IBOutlet weak var headlineDateLbl: UILabel!
    @IBOutlet weak var headlineDescriptionLbl: UILabel!
    
    @IBOutlet weak var backBtn: UIButton!
    //MARK: Properties
    public var selectedCellViewModel: NewsTableViewCellModel?
    public var savedCellViewModel: Headlines?

    //MARK: Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        backBtn.setButtonRounded()
        bindDataToUI()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    //MARK: Bind Data To UI
    func bindDataToUI(){
         if NetworkConnection.isConnectedToNetwork(){
            bindOnlineData()
         }else{
            bindOfflineData()
        }
    }
    
    func bindOfflineData(){
        guard let selectedCellViewModel = savedCellViewModel else { return }
        headlineTitleLbl.text = selectedCellViewModel.title
        headlineAuthorLbl.text = selectedCellViewModel.author
        headlineDescriptionLbl.text = selectedCellViewModel.descrip
        var publishedDate = selectedCellViewModel.date ?? ""
        if let dotRange = publishedDate.range(of: "T") {
            publishedDate.removeSubrange(dotRange.lowerBound..<publishedDate.endIndex)
            headlineDateLbl.text = publishedDate
        }else{
            headlineDateLbl.text = selectedCellViewModel.date
        }
        
        let posterURL = selectedCellViewModel.poster ?? ""
        if posterURL != ""{
            if let headlinePosterURL = URL(string: posterURL){
                headlinePosterImgView.setImage(fromURL: headlinePosterURL, animatedOnce: true, withPlaceholder: #imageLiteral(resourceName: "placeHolder"))
            } else {
                return
            }
        }else{
            return
        }
    }
    
    func bindOnlineData(){
        guard let selectedCellViewModel = selectedCellViewModel else { return }
        headlineTitleLbl.text = selectedCellViewModel.title
        headlineAuthorLbl.text = selectedCellViewModel.author
        headlineDescriptionLbl.text = selectedCellViewModel.description
        var publishedDate = selectedCellViewModel.publishedAt
        if let dotRange = publishedDate.range(of: "T") {
            publishedDate.removeSubrange(dotRange.lowerBound..<publishedDate.endIndex)
            headlineDateLbl.text = publishedDate
        }else{
            headlineDateLbl.text = selectedCellViewModel.publishedAt
        }
        
        let posterURL = selectedCellViewModel.urlToImage
        if let headlinePosterURL = URL(string: posterURL){
            headlinePosterImgView.setImage(fromURL: headlinePosterURL, animatedOnce: true, withPlaceholder: #imageLiteral(resourceName: "placeHolder"))
        } else {
            return
        }
    }
    
    //MARK: User Interaction
    @IBAction func backBtnTapped(_ sender: Any) {
        self.navigationController?.backToViewController(vc: NewsListViewController.self)
    }
}
