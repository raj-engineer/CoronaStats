//
//  CountriesViewModelProtocol.swift
//  CoronaStats
//
//  Created by Rajesh Rajesh on 03/12/22.
//

import Foundation

protocol CountriesViewModelProtocol {
    var countries: Dynamic<[String]?> { get }
    var selectedData: String? { get set }
    var error: Dynamic<String?> { get }
    func fetchCountries()
    func didSelectItemAt(indexPath: IndexPath)
    var filteredItems: [String]? { get set }
}

