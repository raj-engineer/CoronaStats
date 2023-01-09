//
//  DetailDataSource.swift
//  CoronaStats
//
//  Created by Rajesh Rajesh on 08/01/23.
//

import Foundation

// MARK: - Protocol
protocol DetailDataSourceProtocol: AnyObject {
    func fetchCountryDetail(apiRequest: APIRequest<DetailResource>, completion: @escaping (Detail?, Error?) -> ())
}

// MARK: - Class
class DetailDataSource: DetailDataSourceProtocol {
    
    // MARK: - private Properties
    private var request: APIRequest<DetailResource>?
    
    // MARK: - Protocol Function
    func fetchCountryDetail(apiRequest: APIRequest<DetailResource>, completion: @escaping (Detail?, Error?) -> ()) {
        self.request = apiRequest
        apiRequest.execute(withCompletion: completion)
    }
}
