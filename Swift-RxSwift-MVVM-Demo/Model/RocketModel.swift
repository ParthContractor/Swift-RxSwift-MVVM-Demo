//
//  RocketModel.swift
//  Swift-RxSwift-MVVM-Demo
//
//  Created by Parth on 24/11/19.
//  Copyright © 2019 Parth. All rights reserved.
//

import Foundation

struct RocketModel: Codable {
    let rocketId: String
    let rocketName: String
    let rocketType: String
    let successRate: Int?
    let country: String?
    let company: String?
    let costPerLaunch: String?
    let wikipedia: String?
    let description: String?
    let firstFlight: String?
    let height: Height?
    let diameter: Diameter?
    let mass: Mass?

    enum CodingKeys: String, CodingKey {
        case rocketId = "rocket_id"
        case rocketName = "rocket_name"
        case rocketType = "rocket_type"
        case successRate = "success_rate_pct"
        case country = "country"
        case company = "company"
        case costPerLaunch = "cost_per_launch"
        case wikipedia = "wikipedia"
        case description = "description"
        case firstFlight = "first_flight"
        case height = "height"
        case diameter = "diameter"
        case mass = "mass"
    }
}

struct Height: Codable {
    let meters: String

    enum CodingKeys: String, CodingKey {
        case meters = "meters"
    }
}

struct Diameter: Codable {
    let meters: String

    enum CodingKeys: String, CodingKey {
        case meters = "meters"
    }
}

struct Mass: Codable {
    let kg: String

    enum CodingKeys: String, CodingKey {
        case kg = "kg"
    }
}

