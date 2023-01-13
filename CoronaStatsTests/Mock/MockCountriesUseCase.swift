//
//  MockCountriesUseCase.swift
//  CoronaStatsTests
//
//  Created by Rajesh Rajesh on 09/01/23.
//

@testable import CoronaStats

final class MockCountriesUseCase: MockBase, GetCountriesUseCaseProtocol {
    // MARK: - Properties
    var countriesData: CountriesEntity?
    
    // MARK: - Protocol Function
    
    func fetchCountries(completion: @escaping CoronaStats.CountriesEntityResponse) {
        if let data = countriesData {
            completion(.success(data))
        } else {
            completion(.failure(ErrorResult.custom(string: mockErrorMessage)))
        }
    }
}
