//
//  CountriesRepository.swift
//  CoronaStats
//
//  Created by Rajesh Rajesh on 07/01/23.
//

import Foundation

class CountriesRepository: CountriesRepositoryProtocol {
    // MARK: - Private Properties
    private let dataSource: CountriesDataSourceProtocol
    
    // MARK: - init
    init(dataSource: CountriesDataSourceProtocol) {
        self.dataSource = dataSource
    }
    
    // MARK: - function
    func fetchCountries(completion: @escaping (CountriesEntity?, Error?) -> ()) {
        let resource = CountriesResource()
        let request = APIRequest(resource: resource)
        self.dataSource.fetchCountries(apiRequest: request) { countries, err in
            let countriesEntity = CountriesMapper().getCountriesEntity(responseModel: countries)
           completion(countriesEntity,err)
        }
    }
    
    
}
