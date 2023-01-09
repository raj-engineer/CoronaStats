//
//  GetCountries.swift
//  CoronaStats
//
//  Created by Rajesh Rajesh on 06/01/23.
//

import Foundation

// MARK: - Protocol
protocol GetCountriesUseCaseProtocol : AnyObject {
    func fetchCountries(completion: @escaping (CountriesEntity?, Error?) -> ())
}

// MARK: - Class
class GetCountriesUseCase: GetCountriesUseCaseProtocol {
    
    // MARK: - Properties
    private let repository: CountriesRepositoryProtocol
    
    // MARK: - init
    init(repository: CountriesRepositoryProtocol) {
        self.repository = repository
    }
    
    // MARK: - function
    func fetchCountries(completion: @escaping (CountriesEntity?, Error?) -> ()) {
        //
        self.repository.fetchCountries(completion: completion)
    }
}

