//
//  Countries.swift
//  CoronaStats
//
//  Created by Rajesh Rajesh on 03/12/22.
//

import Foundation

// MARK: - Countries
struct Countries: Decodable {
    let get: String?
    let response: [String]?
    let results: Int?
}
