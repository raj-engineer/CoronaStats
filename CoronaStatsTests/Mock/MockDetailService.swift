//
//  MockDetailService.swift
//  CoronaStatsTests
//
//  Created by Rajesh Rajesh on 05/12/22.
//

import Foundation
@testable import CoronaStats

class MockDetailService: DetailServiceProtocol {
    // MARK: - Properties
    var detailData: Detail?
    
    // MARK: - Protocol Function
    func fetchCountryDetail(searchText: String, completion: @escaping (Detail?, Error?) -> ()) {
        if let data = detailData {
            completion(data, nil)
        } else {
            completion(nil, ErrorResult.custom(string: "mock Error"))
        }
    }
}
