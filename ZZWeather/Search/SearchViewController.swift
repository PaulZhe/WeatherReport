//
//  SearchViewController.swift
//  ZZWeather
//
//  Created by zhangzhe on 2019/12/18.
//  Copyright © 2019 zhangzhe. All rights reserved.
//

import UIKit

protocol SearchViewControllerDelegate {
    func passTheSelectedCityNameToSelectController(selectedCityName : String) -> ()
}

class SearchViewController: UIViewController {
    
    private var searchResultsList = Array<String>()
    private var searchView = SearchView(frame: CGRect(x: 0, y: 0, width: DeviceWidth, height: DeviceHeight))
    
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
        self.view.addSubview(searchView)
        
        self.searchView.tableView.delegate = self
        self.searchView.tableView.dataSource = self
        
        self.initializeSearchController()
    }
    
    private func initializeSearchController() {
        //设置searchController
        self.searchView.searchController = UISearchController.init(searchResultsController: nil)
        self.searchView.searchController?.searchResultsUpdater = self
        self.searchView.searchController!.hidesNavigationBarDuringPresentation = false
        //是否添加半透明覆盖层
        self.searchView.searchController?.obscuresBackgroundDuringPresentation = false
        self.definesPresentationContext = true
        self.searchView.searchController!.searchBar.placeholder = "输入城市"
        self.searchView.tableView.tableHeaderView = self.searchView.searchController?.searchBar
    }

}

extension SearchViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResultsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "commonCell", for: indexPath)

        cell.backgroundColor = UIColor.clear
        cell.contentView.backgroundColor = UIColor.clear
        cell.textLabel?.textColor = UIColor.white
        cell.textLabel?.text = searchResultsList[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCityName = self.searchResultsList[indexPath.row]
        self.delegate?.passTheSelectedCityNameToSelectController(selectedCityName: selectedCityName)

        self.dismiss(animated: true, completion: nil)
        self.dismiss(animated: true, completion: nil)
    }
}

extension SearchViewController : UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        let inputStr : String = searchController.searchBar.text ?? ""

        if searchResultsList.count > 0 {
            searchResultsList.removeAll()
        }

        RequestManager.manager.requestLocations(with: inputStr, success: { (locationMessageModel) in
            
            let concreteLocationBasicMessages = locationMessageModel.HeWeather6[0].basic
            
            for concreteLocationBasicItem in concreteLocationBasicMessages {
                self.searchResultsList.append(concreteLocationBasicItem.location)
            }
            
            DispatchQueue.main.async {
                self.searchView.tableView.reloadData()
            }
        }) { (error) in
            
            switch error {
            case RequestError.dataIsNil:
                print("data is nil")
            case RequestError.jsonDecodeFailed:
                print("JSON decode failed")
            case RequestError.urlHasWrong:
                print("URL is wrong")
            default:
                print(error)
            }
        }
    }
}
