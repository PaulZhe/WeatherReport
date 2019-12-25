//
//  SelectViewController.swift
//  ZZWeather
//
//  Created by zhangzhe on 2019/12/17.
//  Copyright © 2019 zhangzhe. All rights reserved.
//

import UIKit

extension URL {
    
    static func initChinese(string : String) -> URL {
        let urlWithChinese = string.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        let url = URL.init(string: urlWithChinese!)
        return url!
    }
    
//    static func encodedURLFrom(string: String) -> URL? {
//        
//    }
}

class SelectViewController: UIViewController, SearchViewControllerDelegate {
    
    var selectView = SelectView.init(frame: CGRect(x: 0, y: 0, width: 414, height: 736))
    var showCityNames = Array<String>()
    var tmpArray = Array<String>()
    var timeArray = Array<String>()
    
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
            searchViewController.showCityNames = self.showCityNames
            searchViewController.delegate = self
            self.present(searchViewController, animated: true, completion: nil)
        }
    }

    
    func pass(array: Array<String>) {
        self.showCityNames = array
        
        // urlcomponents (url builder)
        
        let urlStr = "https://free-api.heweather.com/s6/weather/now" + "?" + "location=" + (showCityNames.last ?? "") + "&key=c563861f72c649f2a698a472080eaa8c"
        let url = URL.initChinese(string: urlStr)
        
        let request : URLRequest = URLRequest.init(url: url)
        URLSession.shared.dataTask(with: request) { (data : Data?, response : URLResponse?, erroe : Error?) in
            do {
                let dic : Dictionary = try (JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableLeaves) as! Dictionary<String, Array<Dictionary<String, AnyObject>>>)
                var str : String = dic["HeWeather6"]?[0]["update"]?["loc"] as! String
                self.timeArray.append(str)
                
                str = dic["HeWeather6"]?[0]["now"]?["tmp"] as! String
                self.tmpArray.append(str)
                
                DispatchQueue.main.async {
                    self.selectView.tableView.reloadData()
                }
            } catch {
                print(error)
            }
        }.resume()
    }
    
}

extension SelectViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return showCityNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : SelectTableViewCell = selectView.tableView.dequeueReusableCell(withIdentifier: "selectCell", for: indexPath) as! SelectTableViewCell
        cell.timeLabel.text = timeArray[indexPath.row]
        cell.siteLabel.text = showCityNames[indexPath.row]
        cell.temperatrueLabel.text = tmpArray[indexPath.row] + "°"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return SelectTableViewCell.cellHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectView.tableView.deselectRow(at: indexPath, animated: true)
    }
}
