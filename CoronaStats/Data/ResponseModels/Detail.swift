//
//  Detail.swift
//  CoronaStats
//
//  Created by Rajesh Rajesh on 04/12/22.
//

// MARK: - Detail
struct Detail: Decodable {
    var get: String?
    let response: [Response]?
    let results: Int?
}

struct Response: Decodable {
    let country: String
    var cases: Cases?
    var deaths: Deaths?
}

struct Cases: Decodable {
    let total: Int?
    let recovered: Int?
    let new: String?
    let active: Int?
}

struct Deaths: Decodable {
    let new: String?
    let total: Int?
}
