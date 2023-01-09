//
//  GetDetailUseCase.swift
//  CoronaStats
//
//  Created by Rajesh Rajesh on 08/01/23.
//

import Foundation

// MARK: - Protocol
protocol GetDetailUseCaseProtocol : AnyObject {
    func fetchCountryDetail(searchText: String, completion: @escaping (DetailEntity?, Error?) -> ())
}

// MARK: - Class
class GetDetailUseCase: GetDetailUseCaseProtocol {
    
    // MARK: - Properties
    private let repository: DetailRepositoryProtocol
    
    // MARK: - init
    init(repository: DetailRepositoryProtocol) {
        self.repository = repository
    }
    
    // MARK: - function
    func fetchCountryDetail(searchText: String, completion: @escaping (DetailEntity?, Error?) -> ()) {
        self.repository.fetchCountryDetail(searchText: searchText, completion: completion)
    }
}
