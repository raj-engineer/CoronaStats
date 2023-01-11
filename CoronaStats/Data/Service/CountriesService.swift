//
//  CountriesService.swift
//  CoronaStats
//
//  Created by Rajesh Rajesh on 11/01/23.
//


import Foundation

// MARK: - Protocol
protocol CountriesServiceProtocol: AnyObject {
    func fetchCountries(completion: @escaping (Result<Countries, Error>) -> ())
}

final class CountriesService: CountriesServiceProtocol {
    
    // MARK: - Private Properties
    private let networkService: NetworkServiceProtocol
    
    // MARK: - init
    init(networkService: NetworkServiceProtocol = NetworkService()) {
        self.networkService = networkService
    }
    // MARK: - Protocol Function
   
    func fetchCountries(completion: @escaping (Result<Countries, Error>) -> ()) {
        let networkConfig = NetworkConfig(path: UrlEnum.countries, method: .get)
        self.networkService.execute(networkConfig: networkConfig, completion: completion)
    }
}
