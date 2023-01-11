//
//  GetCountries.swift
//  CoronaStats
//
//  Created by Rajesh Rajesh on 06/01/23.
//

import Foundation

// MARK: - Protocol
protocol GetCountriesUseCaseProtocol : AnyObject {
    func fetchCountries(completion: @escaping CountriesEntityResponse)
}

// MARK: - Class
final class GetCountriesUseCase: GetCountriesUseCaseProtocol {
    
    // MARK: - Properties
    private let repository: CountriesRepositoryProtocol
    
    // MARK: - init
    init(repository: CountriesRepositoryProtocol = CountriesRepository()) {
        self.repository = repository
    }
    
    // MARK: - function
    func fetchCountries(completion: @escaping CountriesEntityResponse) {
        self.repository.fetchCountries(completion: completion)
    }
}

