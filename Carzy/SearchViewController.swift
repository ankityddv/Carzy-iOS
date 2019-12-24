//
//  SearchViewController.swift
//  Carzy
//
//  Created by ANKIT YADAV on 24/12/19.
//  Copyright © 2019 ANKIT YADAV. All rights reserved.
//

import UIKit

let searchController = UISearchController(searchResultsController: nil)
let searchBarOne = UISearchBar()

class SearchViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate {
    
    let data = ["Physics","Chemistry","JEE Physics Syllabus","JEE Chemistry SYllabus","Gravity","Electrochemical","Mathematics-RELATION & FUNCTION CHAPTER-1 INTRO","Circles"]
    var videoCArr = ["gLq9lWHTadQ","rwXL73AkX20","gLq9lWHTadQ","rwXL73AkX20","4K7cRxXuQ_k","j7PYqR1iGMg","u9xJ3qgG2yk","ZHyAEqJw90Y"]
    
    @IBOutlet weak var tableView: UITableView!
    
    
    var filteredData = [String]()
    var searching = false
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searching{
            return filteredData.count
        }
        else{
            return data.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if searching{
            let cell:SearchTableViewCell = tableView.dequeueReusableCell(withIdentifier: "SearchTableViewCell", for: indexPath) as! SearchTableViewCell
            cell.label.text = filteredData[indexPath.row]
            return cell
        }
        else{
            let cell:SearchTableViewCell = tableView.dequeueReusableCell(withIdentifier: "SearchTableViewCell", for: indexPath) as! SearchTableViewCell
            cell.label.text = data[indexPath.row]
            return cell
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
    }
    
    func setupNavBar() {
        let nav = self.navigationController?.navigationBar
        
        nav?.prefersLargeTitles = true
        nav?.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(red:1.00, green:0.30, blue:0.40, alpha:1.0)]
        nav?.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(red:1.00, green:0.30, blue:0.40, alpha:1.0)]
        UINavigationBar.appearance().tintColor = UIColor.white
        
//        let searchController = UISearchController(searchResultsController: nil)
//        let searchBar = UISearchBar()
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).defaultTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(red:1.00, green:0.30, blue:0.40, alpha:1.0)]
    }
    
    func searchBar(_ searchBarOne: UISearchBar, textDidChange searchText: String) {
        filteredData = data.filter({$0.prefix(searchText.count) == searchText})
        searching = true
        tableView.reloadData()
    }

}
