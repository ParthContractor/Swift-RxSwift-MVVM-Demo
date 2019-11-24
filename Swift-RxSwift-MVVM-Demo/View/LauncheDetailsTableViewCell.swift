//
//  LauncheDetailsTableViewCell.swift
//  Swift-RxSwift-MVVM-Demo
//
//  Created by Parth on 25/11/19.
//  Copyright © 2019 Parth. All rights reserved.
//

import UIKit

class LauncheDetailsTableViewCell: UITableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .`default`, reuseIdentifier: reuseIdentifier)
        self.accessoryType = .none
        self.selectionStyle = .none
        textLabel?.numberOfLines = 0
        decorateTitleLabel()
    }
    
    private func decorateTitleLabel()  {
        textLabel?.adjustsFontSizeToFitWidth = false
        textLabel?.font = UIFont.ThemeFont.titleFont
        textLabel?.textColor = UIColor.ThemeColor.titleColor
    }
    
    @available (*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
