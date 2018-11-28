//
//  NewsView.swift
//  NewsApp
//
//  Created by Macbook on 24/11/2018.
//  Copyright © 2018 Big Nerd Ranch. All rights reserved.
//

import UIKit
import WebKit
import Alamofire

class WebNewsView: UIViewController, WKUIDelegate, WKNavigationDelegate {
    
    var newsURL = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView.navigationDelegate = self
        spinner.startAnimating()
        let myURL = URL(string: newsURL)
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
        
    }
    
    
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        spinner.stopAnimating()
    }
    
    @IBOutlet private weak var webView: WKWebView!
    
    @IBOutlet private weak var spinner: UIActivityIndicatorView!
    
}
