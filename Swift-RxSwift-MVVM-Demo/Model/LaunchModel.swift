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

    enum CodingKeys: String, CodingKey {
        case flightNumber = "flight_number"
        case missionName = "mission_name"
    }
}
