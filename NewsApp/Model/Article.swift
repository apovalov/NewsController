//
//  Article.swift
//  NewsApp
//
//  Created by Macbook on 18/11/2018.
//  Copyright © 2018 Big Nerd Ranch. All rights reserved.
//


let themes = ["Russia", "Bitcoin", "Ecology", "Economy", "Space", "Psychology", "Ai", "Apple", "Politics", "Sport"]

import Foundation

struct NewsContainer: Codable {
    var status: String
    var totalResults: Int
    var articles: [Article]
}


struct Article: Codable {
    struct Source: Codable {
        var id: String?
        var name: String?
    }
    var author: String?
    var theme: String?
    var urlToImage: String?
    var title: String?
    var description: String?
    var url: String?
    var publishedAt: String?
    var content: String?
    var source: Source?
}



