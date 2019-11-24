//
//  Constants.swift
//  Swift-RxSwift-MVVM-Demo
//
//  Created by Parth on 23/11/19.
//  Copyright © 2019 Parth. All rights reserved.
//

import Foundation
import UIKit

struct AppConstants {
    static let baseURL = URL(string: "https://api.spacexdata.com/v3/")!
}
extension UIFont {
    struct ThemeFont {
        static let titleFont = UIFont.systemFont(ofSize: 22)
        static let subTitleFont = UIFont.systemFont(ofSize: 20)
    }
}
extension UIColor {
    struct ThemeColor {
        static let navigationBarTintColor = UIColor.orange
        static let navigationTintColor = UIColor.yellow
        static let titleColor = UIColor.orange
        static let subTitleColor = UIColor.green
    }
}
