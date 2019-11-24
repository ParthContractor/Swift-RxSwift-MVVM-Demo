//
//  LaunchModel.swift
//  Swift-RxSwift-MVVM-Demo
//
//  Created by Parth on 24/11/19.
//  Copyright © 2019 Parth. All rights reserved.
//

import Foundation

struct LaunchModel: Codable {
    let flightNumber: Int
    let missionName: String
    let launchYear: String
    let launchDateUtc: String
    let isTentative: Bool?
    let isLaunchSuccessful: Bool?
    let launchWindow: Int?
    let rocket: RocketModel

    enum CodingKeys: String, CodingKey {
        case flightNumber = "flight_number"
        case missionName = "mission_name"
        case launchYear = "launch_year"
        case launchDateUtc = "launch_date_utc"
        case isTentative = "is_tentative"
        case isLaunchSuccessful = "launch_success"
        case launchWindow = "launch_window"
        case rocket = "rocket"
    }
}
