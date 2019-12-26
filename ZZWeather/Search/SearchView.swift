//
//  SearchView.swift
//  ZZWeather
//
//  Created by zhangzhe on 2019/12/18.
//  Copyright © 2019 zhangzhe. All rights reserved.
//

import UIKit

class SearchView: UIView {

    lazy var tableView : UITableView = {
        let tableView = UITableView(frame: self.bounds, style: UITableView.Style.plain)
        tableView.backgroundColor = UIColor.clear
        return tableView
    }()
    
    private lazy var backGroundImageView : UIImageView = {
        
        let backGroundImageView = UIImageView(frame: self.bounds)
        backGroundImageView.image = UIImage(named: "back2.jpg")
        return backGroundImageView
    }()
    
    var searchController : UISearchController?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initializeView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initializeView() {
        self.addSubview(backGroundImageView)
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "commonCell")
        self.addSubview(tableView)
    }
}
