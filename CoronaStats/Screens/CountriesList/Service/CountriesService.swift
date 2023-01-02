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
    
    // MARK: - Protocol Function
    func fetchCountries(completion: @escaping (Countries?, Error?) -> ()) {
        let urlString = UrlEnum.countryUrl
        ApiService().fetchGenericJSONData(urlString: urlString, completion: completion)
    }
}
