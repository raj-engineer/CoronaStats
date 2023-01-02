//
//  detailViewModelProtocol.swift
//  CoronaStats
//
//  Created by Rajesh Rajesh on 04/12/22.
//

import Foundation

protocol DetailViewModelProtocol {
    var detail: Dynamic<[Response]?> { get }
    var countryName: String { get }
    func getCountryDetail() -> DetailViewModelMapper?
    func fetchCountryDetail()
}
