//
//  NewsCell.swift
//  NewsApp
//
//  Created by Admin on 9/10/19.
//  Copyright © 2019 Farooq. All rights reserved.
//

import UIKit

class NewsCell: UITableViewCell {

    @IBOutlet weak var newsTitleLbl: UILabel!
    @IBOutlet weak var newsAuthorLbl: UILabel!
    @IBOutlet weak var newsDateLbl: UILabel!
    @IBOutlet weak var newsImageView: UIImageView!
    
    // MARK: - Properties
    public static let reuseIdentifier = "newsCell"
    
    public var viewModel: NewsTableViewCellModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            newsTitleLbl.text = viewModel.title
            newsAuthorLbl.text = viewModel.author
            var publishedDate = viewModel.publishedAt
            if let dotRange = publishedDate.range(of: "T") {
                publishedDate.removeSubrange(dotRange.lowerBound..<publishedDate.endIndex)
                newsDateLbl.text = publishedDate
            }else{
                newsDateLbl.text = viewModel.publishedAt
            }
            let newsPosterURL = viewModel.urlToImage
            newsImageView.setImage(fromURL: URL(string: newsPosterURL)!)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
