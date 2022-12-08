//
//  Detail.swift
//  CoronaStats
//
//  Created by Rajesh Rajesh on 04/12/22.
//

import Foundation

// MARK: - Detail
struct Detail: Codable {
    var get: String?
    let response: [Response]?
    let results: Int?
}

struct Response: Codable {
    let country: String
    var cases: Cases?
    var deaths: Deaths?
}

struct Cases: Codable {
    let total: Int?
    let recovered: Int?
    let new: String?
    let active: Int?
}

struct Deaths: Codable {
    let new: String?
    let total: Int?
}
