//
//  MockCountriesService.swift
//  CoronaStatsTests
//
//  Created by Rajesh Rajesh on 13/01/23.
//

@testable import CoronaStats

final class MockCountriesService: MockBase,CountriesServiceProtocol {

    // MARK: - Properties
    var data: Countries?
    
    // MARK: - Protocol Function
    func fetchCountries(completion: @escaping (Result<Countries, Error>) -> ()) {
        if let _data = data {
            completion(.success(_data))
        } else {
            completion(.failure(NetworkError.failed))
        }
    }
}

