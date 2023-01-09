//
//  DetailRepository.swift
//  CoronaStats
//
//  Created by Rajesh Rajesh on 08/01/23.
//

import Foundation

class DetailRepository: DetailRepositoryProtocol {
    
    // MARK: - Private Properties
    private let dataSource: DetailDataSourceProtocol
    
    // MARK: - init
    init(dataSource: DetailDataSourceProtocol) {
        self.dataSource = dataSource
    }
    
    // MARK: - function
    func fetchCountryDetail(searchText: String, completion: @escaping (DetailEntity?, Error?) -> ()) {
        let resource = DetailResource(queryValue: searchText)
        let request = APIRequest(resource: resource)
        self.dataSource.fetchCountryDetail(apiRequest: request) { detail, err in
            let detailEntity = DetailMapper().getDetailEntity(responseModel: detail)
            completion(detailEntity,err)
        }
    }
}
