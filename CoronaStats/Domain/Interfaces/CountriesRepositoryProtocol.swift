//
//  CountriesRepositoryProtocol.swift
//  CoronaStats
//
//  Created by Rajesh Rajesh on 07/01/23.
//

import Foundation

typealias CountriesEntityResponse = (Result<CountriesEntity, Error>) -> Void

protocol CountriesRepositoryProtocol: AnyObject {
    func fetchCountries(completion: @escaping CountriesEntityResponse)
}

