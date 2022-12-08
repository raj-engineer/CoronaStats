//
//  MockCountriesService.swift
//  CoronaStatsTests
//
//  Created by Rajesh Rajesh on 05/12/22.
//

import Foundation
@testable import CoronaStats

class MockCountriesService: CountriesServiceProtocol {
    // MARK: - Properties
    var countriesData: Countries?
    
    // MARK: - Function
    func fetchCountries(completion: @escaping (Countries?, Error?) -> ()) {
        if let data = countriesData {
            completion(data, nil)
        } else {
            completion(nil, ErrorResult.custom(string: "mock Error"))
        }
    }
}
