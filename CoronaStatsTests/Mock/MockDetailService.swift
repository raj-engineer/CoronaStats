//
//  MockDetailService.swift
//  CoronaStatsTests
//
//  Created by Rajesh Rajesh on 13/01/23.
//

@testable import CoronaStats

final class MockDetailService: MockBase,DetailServiceProtocol {

    // MARK: - Properties
    var data: Detail?
    
    // MARK: - Protocol Function
    func fetchCountryDetail(searchText: String, completion: @escaping (Result<Detail, Error>) -> ()) {
        if let _data = data {
            completion(.success(_data))
        } else {
            completion(.failure(NetworkError.failed))
        }
    }
}
