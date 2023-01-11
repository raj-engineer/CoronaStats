//
//  CountriesMapper.swift
//  CoronaStats
//
//  Created by Rajesh Rajesh on 07/01/23.
//

import Foundation

protocol CountriesMapperProtocol {
    func getCountriesEntity(responseModel: Countries) -> CountriesEntity
}

struct CountriesMapper: CountriesMapperProtocol {
    
    func getCountriesEntity(responseModel: Countries) -> CountriesEntity {
        guard let response = responseModel.response else { return CountriesEntity() }
        return CountriesEntity(response: response)
    }
}
