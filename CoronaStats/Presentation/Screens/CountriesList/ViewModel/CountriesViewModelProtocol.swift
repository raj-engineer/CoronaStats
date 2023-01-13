//
//  CountriesViewModelProtocol.swift
//  CoronaStats
//
//  Created by Rajesh Rajesh on 03/12/22.
//
import Foundation

protocol CountriesListViewModelInput {
    func fetchCountries()
    func filterCountriesList(for searchText: String)
}

protocol CountriesListViewModelOutput {
    var loaderStatus: Dynamic<Bool> { get }
    var reloadTable: Dynamic<Bool> { get }
    var error: Dynamic<String?> { get }
    func numberOfSection() -> Int
    func getItem(at indexPath: IndexPath) -> String
    func getCountriesEntity() -> CountriesEntity
}


protocol CountriesListViewModelProtocol: CountriesListViewModelInput, CountriesListViewModelOutput {
    var input: CountriesListViewModelInput { get }
    var output: CountriesListViewModelOutput { get }
}

