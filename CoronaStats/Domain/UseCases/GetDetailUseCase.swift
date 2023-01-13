//
//  GetDetailUseCase.swift
//  CoronaStats
//
//  Created by Rajesh Rajesh on 08/01/23.
//

// MARK: - Protocol
protocol GetDetailUseCaseProtocol : AnyObject {
    func fetchCountryDetail(searchText: String, completion: @escaping DetailEntityResponse)
}

// MARK: - Class
final class GetDetailUseCase: GetDetailUseCaseProtocol {
    
    // MARK: - Properties
    private let repository: DetailRepositoryProtocol
    
    // MARK: - init
    init(repository: DetailRepositoryProtocol = DetailRepository()) {
        self.repository = repository
    }
    
    // MARK: - function
    func fetchCountryDetail(searchText: String, completion: @escaping DetailEntityResponse) {
        repository.fetchCountryDetail(searchText: searchText, completion: completion)
    }
}
