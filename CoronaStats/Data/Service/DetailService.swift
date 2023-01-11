//
//  DetailService.swift
//  CoronaStats
//
//  Created by Rajesh Rajesh on 11/01/23.
//

import Foundation

// MARK: - Protocol
protocol DetailServiceProtocol: AnyObject {
    func fetchCountryDetail(searchText: String,completion: @escaping (Result<Detail, Error>) -> ())
}

// MARK: - Class
final class DetailService: DetailServiceProtocol {
    
    // MARK: - private Properties
    private let networkService: NetworkServiceProtocol
    
    // MARK: - init
    init(networkService: NetworkServiceProtocol = NetworkService()) {
        self.networkService = networkService
    }
    
    // MARK: - Protocol Function
    func fetchCountryDetail(searchText: String, completion: @escaping (Result<Detail, Error>) -> ()) {
        let networkConfig = NetworkConfig(path: UrlEnum.statistics, method: .get, queryParameters: [UrlEnum.queryKey: searchText])
        self.networkService.execute(networkConfig: networkConfig, completion: completion)
    }
}


