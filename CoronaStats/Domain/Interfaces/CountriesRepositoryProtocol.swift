//
//  CountriesRepositoryProtocol.swift
//  CoronaStats
//
//  Created by Rajesh Rajesh on 07/01/23.
//

import Foundation

protocol CountriesRepositoryProtocol : AnyObject {
    func fetchCountries(completion: @escaping (CountriesEntity?, Error?) -> ())
}

