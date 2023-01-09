//
//  CountriesDataSource.swift
//  CoronaStats
//
//  Created by Rajesh Rajesh on 06/01/23.
//

import Foundation

// MARK: - Protocol 
protocol CountriesDataSourceProtocol: AnyObject {
    func fetchCountries(apiRequest: APIRequest<CountriesResource>, completion: @escaping (Countries?, Error?) -> ())
}

class CountriesDataSource: CountriesDataSourceProtocol {
    // MARK: - Private Properties
    private var request: APIRequest<CountriesResource>?
    
    // MARK: - Protocol Function
    func fetchCountries(apiRequest: APIRequest<CountriesResource>, completion: @escaping (Countries?, Error?) -> ()) {
        self.request = apiRequest
        apiRequest.execute(withCompletion: completion)
    }
}
