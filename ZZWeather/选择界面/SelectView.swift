//
//  SelectView.swift
//  ZZWeather
//
//  Created by zhangzhe on 2019/12/17.
//  Copyright © 2019 zhangzhe. All rights reserved.
//

import UIKit

struct SelectViewConstants {
    static let fooHeight: CGFloat = 10
}

class SelectView: UIView {
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    typealias BottomButtonClosure = (UIButton) -> ()
    
    lazy var bottomView : UIView = {
        let bottomView = UIView.init(frame: CGRect(x: 0, y: 692, width: 414, height: 44))
        bottomView.backgroundColor = UIColor.clear
        
        //设置底部bottomButton
        let bottomButton : UIButton = UIButton.init(type: UIButton.ButtonType.custom)
        bottomButton.frame = CGRect(x: 374, y: 7, width: 30, height: 30)
        bottomButton.setImage(UIImage.init(named: "添加"), for: UIControl.State.normal)
        bottomButton.addTarget(self, action: #selector(click(btn:)), for: .touchUpInside)
        bottomView.addSubview(bottomButton)
        
        return bottomView
    }()
    
    lazy var tableView : UITableView = {
        let tableView = UITableView.init(frame: CGRect(x: 0, y: 20, width: 414, height: 672), style: UITableView.Style.plain)
        tableView.backgroundColor = UIColor.clear
        tableView.register(SelectTableViewCell.self, forCellReuseIdentifier: "selectCell")
        
        return tableView
    }()
    
    var bottomButtonHandle : BottomButtonClosure?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initializeView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initializeView() {
        self.layer.contents = UIImage(named: "back1.jpg")?.cgImage
        
        self.addSubview(bottomView)
        self.addSubview(tableView)
        
    }
    
    @objc private func click(btn : UIButton) {
        if self.bottomButtonHandle != nil {
            bottomButtonHandle!(btn)
        }
    }
}

