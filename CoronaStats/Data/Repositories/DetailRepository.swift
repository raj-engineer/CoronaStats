//
//  DetailRepository.swift
//  CoronaStats
//
//  Created by Rajesh Rajesh on 08/01/23.
//

import Foundation

final class DetailRepository: DetailRepositoryProtocol {
    
    // MARK: - Private Properties
    private let service: DetailServiceProtocol
    
    // MARK: - init
    init(service: DetailServiceProtocol = DetailService()) {
        self.service = service
    }
    
    // MARK: - function
    func fetchCountryDetail(searchText: String, completion: @escaping DetailEntityResponse) {
        self.service.fetchCountryDetail(searchText: searchText) { (result: Result<Detail, Error>) in
            switch result {
            case .success(let detail):
                let detailEntity = DetailMapper().getDetailEntity(responseModel: detail)
                completion(.success(detailEntity))
            case .failure(_):
                completion(.failure(NetworkError.failed))
            }

        }
    }
}
