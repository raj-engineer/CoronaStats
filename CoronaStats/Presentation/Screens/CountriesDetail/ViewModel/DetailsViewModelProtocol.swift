//
//  DetailsViewModelProtocol.swift
//  CoronaStats
//
//  Created by Rajesh Rajesh on 08/01/23.
//

import Foundation

protocol DetailViewModelInput {
    func fetchCountryDetail()
}

protocol DetailViewModelOutput {
    var detailEntity: Dynamic<DetailEntity?> { get }
    var loaderStatus: Dynamic<Bool> { get }
    func getCountryDetail() -> DetailEntity?
}

protocol DetailsViewModelProtocol: DetailViewModelInput, DetailViewModelOutput {
    var input: DetailViewModelInput { get }
    var output: DetailViewModelOutput { get }
}
