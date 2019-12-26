//
//  SelectViewController.swift
//  ZZWeather
//
//  Created by zhangzhe on 2019/12/17.
//  Copyright © 2019 zhangzhe. All rights reserved.
//

import UIKit

class SelectViewController: UIViewController, SearchViewControllerDelegate {
    
    var selectView = SelectView.init(frame: CGRect(x: 0, y: 0, width: DeviceWidth, height: DeviceHeight))
    var showCityNames = Array<String>()
    var showCitys = Array<CityMessageModel>()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        initializeView()
    }
    
    fileprivate func initializeView() {
       
        self.view.addSubview(selectView)
        self.selectView.tableView.delegate = self
        self.selectView.tableView.dataSource = self
        selectView.bottomButtonHandle = { (sender : UIButton) -> () in
            let searchViewController = SearchViewController()
            searchViewController.delegate = self
            self.present(searchViewController, animated: true, completion: nil)
        }
    }

    func passTheSelectedCityNameToSelectController(selectedCityName: String) {
        guard !showCityNames.contains(selectedCityName) else {
            print("Selected cityname is existed")
            return
        }
        self.showCityNames.append(selectedCityName)
        
        guard let cityName = showCityNames.last else {
            print("Selected cityname is empty")
            return
        }
        
        RequestManager.manager.requestCityWeather(with: cityName, success: { (cityMessageModel) in
            
            self.showCitys.append(cityMessageModel)
            
            DispatchQueue.main.async {
                self.selectView.tableView.reloadData()
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

extension SelectViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return showCityNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : SelectTableViewCell = selectView.tableView.dequeueReusableCell(withIdentifier: "selectCell", for: indexPath) as! SelectTableViewCell
        cell.timeLabel.text = showCitys[indexPath.row].HeWeather6[0].update.loc
        cell.siteLabel.text = showCityNames[indexPath.row]
        cell.temperatrueLabel.text = showCitys[indexPath.row].HeWeather6[0].now.tmp + "°"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return SelectTableViewCell.cellHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectView.tableView.deselectRow(at: indexPath, animated: true)
    }
}
