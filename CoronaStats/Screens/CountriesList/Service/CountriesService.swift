//
//  CountriesService.swift
//  CoronaStats
//
//  Created by Rajesh Rajesh on 03/12/22.
//

import Foundation

protocol CountriesServiceProtocol : AnyObject {
    func fetchCountries(completion: @escaping (Countries?, Error?) -> ())
}

class CountriesService: CountriesServiceProtocol {
    private var request: APIRequest<CountriesResource>?
    
    // MARK: - Protocol Function
    func fetchCountries(completion: @escaping (Countries?, Error?) -> ()) {
        let resource = CountriesResource()
        let request = APIRequest(resource: resource)
        self.request =  request
        request.execute(withCompletion: completion)
    }
}
