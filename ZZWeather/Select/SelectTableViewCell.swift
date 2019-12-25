//
//  SelectTableViewCell.swift
//  ZZWeather
//
//  Created by zhangzhe on 2019/12/18.
//  Copyright © 2019 zhangzhe. All rights reserved.
//

import UIKit

class SelectTableViewCell: UITableViewCell {
    
    static let cellHeight: CGFloat = 84
    
    lazy var timeLabel : UILabel = {
        var timeLabel = UILabel(frame: CGRect(x: 20, y: 19, width: 200, height: 15))
        timeLabel.textColor = UIColor.white
        timeLabel.font = UIFont.systemFont(ofSize: 15)
        
        return timeLabel
    }()
    
    lazy var siteLabel : UILabel = {
        var siteLabel = UILabel(frame: CGRect(x: 20, y: 41, width: 280, height: 44))
        siteLabel.textColor = UIColor.white
        siteLabel.font = UIFont.systemFont(ofSize: 27)
        
        return siteLabel
    }()
    
    lazy var temperatrueLabel : UILabel = {
        var temperatrueLabel = UILabel(frame: CGRect(x: 310, y: 20, width: 86, height: 44))
        temperatrueLabel.textColor = UIColor.white
        temperatrueLabel.font = UIFont.systemFont(ofSize: 52)
        
        return temperatrueLabel
    }()
    
    fileprivate func initialize() {
        self.contentView.addSubview(timeLabel)
        self.contentView.addSubview(siteLabel)
        self.contentView.addSubview(temperatrueLabel)
        self.backgroundColor = UIColor.clear
        self.contentView.backgroundColor = UIColor.clear
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
