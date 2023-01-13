//
//  DetailRepositoryProtocol.swift
//  CoronaStats
//
//  Created by Rajesh Rajesh on 08/01/23.
//

typealias DetailEntityResponse = (Result<DetailEntity, Error>) -> Void

protocol DetailRepositoryProtocol : AnyObject {
    func fetchCountryDetail(searchText: String, completion: @escaping DetailEntityResponse)
}
