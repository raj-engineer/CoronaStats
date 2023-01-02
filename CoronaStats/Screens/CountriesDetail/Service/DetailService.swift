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
    
    // MARK: - Protocol Function
    func fetchCountryDetail(searchText: String, completion: @escaping (Detail?, Error?) -> ()) {
        let urlString = UrlEnum.detailUrl+searchText
        ApiService().fetchGenericJSONData(urlString: urlString, completion: completion)
    }
}
