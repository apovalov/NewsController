//
//  NewsListViewController.swift
//  
//
//  Created by Macbook on 21/11/2018.
//

import UIKit

class NewsListScreen: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private var articles: [Article] = []
    
    private var page: Int = 0
    private var totalResults: Int = 0
    
    private var refreshControl: UIRefreshControl?
    
    var choosenTheme: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureRefreshControl()
        receiveData()
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
    }
    
    func configureRefreshControl() {
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(startUpdate), for: .valueChanged)
        if let refreshControl = refreshControl {
            tableView.refreshControl = refreshControl
        }
    }
    
    @objc func startUpdate() {
        print("Started update")
        receiveData()
    }
    
    func receiveData() {
        refreshControl?.beginRefreshing()
        page = 1
        Network.loadNews(theme: choosenTheme, page: page) { [weak self] (result: NewsContainer?, error: Error?) in
            guard let self = self else { return }
            self.refreshControl?.endRefreshing()
            
            guard let result = result else { return }
            self.articles = result.articles
            self.totalResults = result.totalResults
            
            self.tableView.reloadData()
        }
    }
    
    
    func addNewData() {
        Network.loadNews(theme: choosenTheme, page: page) { [weak self] (result: NewsContainer?, error: Error?) in
            guard let self = self else { return }
            
            self.refreshControl?.endRefreshing()
            guard let result = result else { return }
            
            let wasElems = self.articles.count
            self.articles.append(contentsOf: result.articles)
            let indexPathsToReloads = (wasElems ..< wasElems + result.articles.count).map { IndexPath(row: $0 , section: 0) }
            self.tableView.insertRows(at: indexPathsToReloads, with: .bottom)
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellA", for: indexPath) as! NewsCell
        cell.article = articles[indexPath.row]
        print(indexPath)
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "secondTransition", sender: articles[indexPath.row].url)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let tvc = segue.destination as! WebNewsView
        tvc.newsURL = sender as! String
    }
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        print("Current view index path: \(indexPath)")
        if indexPath.row == articles.count - 3 {
            //we are at last cell load more articles
            if articles.count < totalResults {
                page = page + 1
                addNewData()
            }
        }
    }
    
    @IBOutlet private weak var tableView: UITableView!
}
