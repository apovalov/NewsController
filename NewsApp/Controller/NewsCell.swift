//
//  NewsTableViewCell.swift
//  NewsApp
//
//  Created by Macbook on 21/11/2018.
//  Copyright © 2018 Big Nerd Ranch. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage


class NewsCell: UITableViewCell {
    
    var article: Article? {
        didSet {
            guard let articleOne = article else { return }
            
            if let urlStr = articleOne.urlToImage,
                let url = URL(string: urlStr),
                let holder = UIImage(named: "placeholder")  {
                
                smallImage.af_setImage(withURL: url, placeholderImage: holder)
            }
            if let title = articleOne.title {
                newsTitleLable.text = title
            }
            if let strDate = articleOne.publishedAt {
                postTime.text = convertDateFormatter(date: strDate)
            }
            if let description = articleOne.description{
                desription.text = description
            }
        }
    }
    
    func convertDateFormatter(date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        guard let convertedDate = dateFormatter.date(from: date) else { return "" }
        
        dateFormatter.dateFormat = "dd MMM yy"
        return dateFormatter.string(from: convertedDate)
    }
    
    @IBOutlet private weak var smallImage: UIImageView!
    
    @IBOutlet private weak var newsTitleLable: UILabel!
    
    @IBOutlet private weak var postTime: UILabel!
    
    @IBOutlet private weak var desription: UILabel!
}
