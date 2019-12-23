//
//  SearchViewController.swift
//  ZZWeather
//
//  Created by zhangzhe on 2019/12/18.
//  Copyright © 2019 zhangzhe. All rights reserved.
//

import UIKit

protocol SearchViewControllerDelegate {
    func pass(array : Array<String>) -> ()
}

class SearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, UISearchResultsUpdating {
    
    var receiveArray = Array<String>()
    var resultsArray = Array<String>()
    var searchView = SearchView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    
    var delegate : SearchViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        initializeView()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        self.searchView.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height)
        self.searchView.tableView.frame = searchView.frame
    }

    private func initializeView() {
        //FIXME:在这个需求里这么写没有什么问题
//        self.searchView.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height)
//        self.searchView.tableView.frame = searchView.frame
        
        self.view.addSubview(searchView)
        self.searchView.tableView.delegate = self
        self.searchView.tableView.dataSource = self
        
        //设置searchController
        self.searchView.searchController = UISearchController.init(searchResultsController: nil)
        self.searchView.searchController?.searchBar.delegate = self
        self.searchView.searchController?.searchResultsUpdater = self
//        self.searchView.searchController!.searchBar.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: 44)
        self.searchView.searchController!.hidesNavigationBarDuringPresentation = false
        //是否添加半透明覆盖层
        self.searchView.searchController?.dimsBackgroundDuringPresentation = false
        self.definesPresentationContext = true
        self.searchView.searchController!.searchBar.placeholder = "输入城市"
        self.searchView.tableView.tableHeaderView = self.searchView.searchController?.searchBar
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resultsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell : UITableViewCell? = tableView .dequeueReusableCell(withIdentifier: "cell")
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "cell")
        }
        cell?.backgroundColor = UIColor.clear
        cell?.contentView.backgroundColor = UIColor.clear
        cell?.textLabel?.textColor = UIColor.white
        cell?.textLabel?.text = resultsArray[indexPath.row]
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if self.receiveArray.contains(self.resultsArray[indexPath.row]) == false {
            self.receiveArray.append(self.resultsArray[indexPath.row])
            self.delegate?.pass(array: receiveArray)
        }
        self.dismiss(animated: true, completion: nil)
        self.dismiss(animated: true, completion: nil)
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        let inputStr : String = searchController.searchBar.text ?? ""

        if resultsArray.count > 0 {
            resultsArray.removeAll()
        }

        let urlStr = "https://search.heweather.com/find" + "?" + "location=" + inputStr + "&key=c563861f72c649f2a698a472080eaa8c"
        var request : URLRequest = URLRequest.init(url: URL.init(string: urlStr)!)
        request.httpMethod = "GET"

        URLSession.shared.dataTask(with: request) { (data : Data?, response : URLResponse?, error : Error?) in
            do {

                let dic : Dictionary = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableLeaves) as! Dictionary<String, Array<Dictionary<String, AnyObject>>>
                let array : Array? = dic["HeWeather6"]![0]["basic"] as? Array<Dictionary<String, AnyObject>>
                for obj in array ?? [] {
                    self.resultsArray.append(obj["location"] as! String)
                }

                DispatchQueue.main.async {
                    self.searchView.tableView.reloadData()
                }
            } catch {
                print(error)
            }

        }.resume()
    }

}
