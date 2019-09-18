//
//  ViewController.swift
//  NewsApp
//
//  Created by Admin on 9/10/19.
//  Copyright © 2019 Farooq. All rights reserved.
//

import UIKit

class NewsListViewController: UIViewController {
    
    @IBOutlet weak var mTableView: UITableView!
    
    // MARK: - Injection
    let newsViewModel = NewsViewModel()
    
    //MARK: Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        shadowForNavBar()
        fetchNewsHeadlines()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    func shadowForNavBar(){
        self.navigationController?.navigationBar.layer.shadowColor = UIColor.black.cgColor
        self.navigationController?.navigationBar.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
        self.navigationController?.navigationBar.layer.shadowRadius = 4.0
        self.navigationController?.navigationBar.layer.shadowOpacity = 0.5
        self.navigationController?.navigationBar.layer.masksToBounds = false
    }
    
    func fetchNewsHeadlines(){
            newsViewModel.showLoader(windowView: view)
            newsViewModel.fetchNewsHeadlines { [weak self] in
                self?.reloadData()
            }
    }
    
    //MARK:- Relaod the tableview in order to refresh the list
    func reloadData(){
        DispatchQueue.main.async {
            self.mTableView.reloadData()
        }
    }
}

// MARK: UITableView DataSource Methods
extension NewsListViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsViewModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let newsCell = tableView.dequeueReusableCell(withIdentifier: NewsCell.reuseIdentifier,
                                                           for: indexPath) as? NewsCell else {
                                                            return UITableViewCell()
        }
        if NetworkConnection.isConnectedToNetwork(){
            let cellViewModel = newsViewModel.getCellViewModel(index: indexPath.row)
            newsCell.viewModel = cellViewModel
            return newsCell
        }else{
            let cellViewModel = newsViewModel.fetchSavedHeadlines(index: indexPath.row)
            newsCell.headlineViewModel = cellViewModel
            return newsCell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let headlineDetailViewController = storyBoard.instantiateViewController(withIdentifier: "headlineDetailsViewController") as! HeadlineDetailsViewController
        if NetworkConnection.isConnectedToNetwork(){
            let selectedCellViewModel = newsViewModel.getCellViewModel(index: indexPath.row)
            if (selectedCellViewModel != nil){
                headlineDetailViewController.selectedCellViewModel = selectedCellViewModel
                self.navigationController?.pushViewController(headlineDetailViewController, animated: true)
            }
        }else{
            let savedCellViewModel = newsViewModel.fetchSavedHeadlines(index: indexPath.row)
            if (savedCellViewModel != nil){
                headlineDetailViewController.savedCellViewModel = savedCellViewModel
                self.navigationController?.pushViewController(headlineDetailViewController, animated: true)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let rotationTransform = CATransform3DTranslate(CATransform3DIdentity, 0, -10, 0)
        cell.layer.transform = rotationTransform
        cell.alpha = 0.0
        UIView.animate(withDuration: 0.75){
            cell.layer.transform = CATransform3DIdentity
            cell.alpha = 1.0
        }
    }
}

// MARK: UITableView Delegate Methods
extension NewsListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 188
    }
}
