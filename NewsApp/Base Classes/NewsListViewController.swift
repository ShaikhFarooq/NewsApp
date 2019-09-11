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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        shadowForNavBar()
        fetchNewsHeadlines()
    }
    
    func shadowForNavBar(){
        self.navigationController?.navigationBar.layer.shadowColor = UIColor.black.cgColor
        self.navigationController?.navigationBar.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
        self.navigationController?.navigationBar.layer.shadowRadius = 4.0
        self.navigationController?.navigationBar.layer.shadowOpacity = 0.5
        self.navigationController?.navigationBar.layer.masksToBounds = false
    }
    
    func fetchNewsHeadlines(){
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
        let cellViewModel = newsViewModel.getCellViewModel(index: indexPath.row)
        newsCell.viewModel = cellViewModel
    
        return newsCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}

// MARK: UITableView Delegate Methods
extension NewsListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 188
    }
}
