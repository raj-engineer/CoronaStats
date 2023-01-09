//
//  DetailRepositoryProtocol.swift
//  CoronaStats
//
//  Created by Rajesh Rajesh on 08/01/23.
//

import Foundation

protocol DetailRepositoryProtocol : AnyObject {
    func fetchCountryDetail(searchText: String, completion: @escaping (DetailEntity?, Error?) -> ())
}
