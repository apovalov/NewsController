//
//  ViewController.swift
//  NewsApp
//
//  Created by Macbook on 18/11/2018.
//  Copyright © 2018 Big Nerd Ranch. All rights reserved.
//

import UIKit

class ThemeChooseController: UIViewController, UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return themes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellid", for: indexPath)
        cell.textLabel?.text = themes[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "firstTransition", sender: themes[indexPath.row])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let svc = segue.destination as! NewsListScreen
        svc.choosenTheme = sender as! String
    }
    
    @IBOutlet private weak var tableView: UITableView!
}

