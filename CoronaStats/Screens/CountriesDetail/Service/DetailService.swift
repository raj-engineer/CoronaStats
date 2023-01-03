//
//  DetailService.swift
//  CoronaStats
//
//  Created by Rajesh Rajesh on 04/12/22.
//

import Foundation

protocol DetailServiceProtocol : AnyObject {
    func fetchCountryDetail(searchText: String, completion: @escaping (Detail?, Error?) -> ())
}

class DetailService: DetailServiceProtocol {
    private var request: APIRequest<DetailResource>?
    
    // MARK: - Protocol Function
    func fetchCountryDetail(searchText: String, completion: @escaping (Detail?, Error?) -> ()) {
        let resource = DetailResource(queryValue: searchText)
        let request = APIRequest(resource: resource)
        
        self.request =  request
        request.execute(withCompletion: completion)
    }
}
