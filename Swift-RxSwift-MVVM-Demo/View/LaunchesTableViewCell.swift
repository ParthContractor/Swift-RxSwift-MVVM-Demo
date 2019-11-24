//
//  LaunchesTableViewCell.swift
//  Swift-RxSwift-MVVM-Demo
//
//  Created by Parth on 23/11/19.
//  Copyright © 2019 Parth. All rights reserved.
//
import UIKit

class LaunchesTableViewCell: UITableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        self.accessoryType = .disclosureIndicator
        decorateTitleLabel()
        decorateSubTitleLabel()
    }
    
    private func decorateTitleLabel()  {
        textLabel?.adjustsFontSizeToFitWidth = false
        textLabel?.font = UIFont.ThemeFont.titleFont
        textLabel?.textColor = UIColor.ThemeColor.titleColor
    }
    
    private func decorateSubTitleLabel()  {
        detailTextLabel?.adjustsFontSizeToFitWidth = false
        detailTextLabel?.textColor = UIColor.ThemeColor.subTitleColor
        detailTextLabel?.font = UIFont.ThemeFont.subTitleFont
    }

    @available (*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
