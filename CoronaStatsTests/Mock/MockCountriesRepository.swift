//
//  MockCountriesRepository.swift
//  CoronaStatsTests
//
//  Created by Rajesh Rajesh on 09/01/23.
//


import Foundation
@testable import CoronaStats

class MockCountriesRepository: MockBase,CountriesRepositoryProtocol {
    
    // MARK: - Properties
    var countriesData: CountriesEntity?
    
    // MARK: - Protocol Function
    func fetchCountries(completion: @escaping (CoronaStats.CountriesEntity?, Error?) -> ()) {
        if let data = countriesData {
            completion(data, nil)
        } else {
            completion(nil, ErrorResult.custom(string: mockErrorMessage))
        }
    }
}
