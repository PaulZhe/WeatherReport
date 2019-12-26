//
//  SelectView.swift
//  ZZWeather
//
//  Created by zhangzhe on 2019/12/17.
//  Copyright © 2019 zhangzhe. All rights reserved.
//

import UIKit

//struct SelectViewConstants {
//    static let fooHeight: CGFloat = 10
//}

class SelectView: UIView {
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    typealias BottomButtonClosure = (UIButton) -> ()
    
    private lazy var bottomView : UIView = {
        let bottomView = UIView.init(frame: CGRect(x: 0, y: DeviceHeight * 0.94, width: self.bounds.width, height: DeviceHeight * 0.06))
        bottomView.backgroundColor = UIColor.clear
        
        //设置底部bottomButton
        let bottomButton : UIButton = UIButton.init(type: UIButton.ButtonType.custom)
        let kBottomButtonFromTopOffset : CGFloat = 7
        bottomButton.frame = CGRect(x: DeviceWidth - bottomView.bounds.height + kBottomButtonFromTopOffset, y: kBottomButtonFromTopOffset, width: bottomView.bounds.height - 14, height: bottomView.bounds.height - 14)
        bottomButton.setImage(UIImage.init(named: "添加"), for: UIControl.State.normal)
        bottomButton.addTarget(self, action: #selector(click(btn:)), for: .touchUpInside)
        bottomView.addSubview(bottomButton)
        
        return bottomView
    }()
    
    lazy var tableView : UITableView = {
        let tableView = UITableView.init(frame: CGRect(x: 0, y: 20, width: self.bounds.width, height: self.bounds.height - self.bottomView.bounds.height - 20), style: UITableView.Style.plain)
        tableView.backgroundColor = UIColor.clear
        tableView.register(SelectTableViewCell.self, forCellReuseIdentifier: "selectCell")
        
        return tableView
    }()
    
    private lazy var backGroundImageView : UIImageView = {
        
        let backGroundImageView = UIImageView(frame: self.bounds)
        backGroundImageView.image = UIImage(named: "back1.jpg")
        return backGroundImageView
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
        self.addSubview(backGroundImageView)
        self.addSubview(bottomView)
        self.addSubview(tableView)
        
    }
    
    @objc private func click(btn : UIButton) {
        if let bottomButtonHandle = self.bottomButtonHandle {
            bottomButtonHandle(btn)
        }
    }
}

