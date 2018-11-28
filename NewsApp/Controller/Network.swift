//
//  Model.swift
//  NewsApp
//
//  Created by Macbook on 18/11/2018.
//  Copyright © 2018 Big Nerd Ranch. All rights reserved.
//

import Foundation
import Alamofire

struct Network {
    static let apiKey = "e09cb96623154d2d865e396b12bd741d"
    
    static func loadNews(theme: String, page: Int, completion: @escaping (NewsContainer?, Error?) -> ()) {
        let url = "https://newsapi.org/v2/everything?q="+theme+"&page="+String(page)+"&apiKey="+Network.apiKey
        let myrequest = Alamofire.request(url)
        
        let completionHandler = { (result: DefaultDataResponse) in
            if let error = result.error {
                completion(nil, error)
                return
            }
            guard let data = result.data else {
                completion(nil, nil)
                return
            }
            
            do {
                let result = try JSONDecoder().decode(NewsContainer.self, from: data)
                completion(result, nil)
            } catch {
                print(error.localizedDescription)
                completion(nil, error)
            }
        }
        
        myrequest.response(completionHandler: completionHandler)
        print("All has done")
    }
}




