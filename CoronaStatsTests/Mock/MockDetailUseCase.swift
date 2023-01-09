//
//  MockDetailUseCase.swift
//  CoronaStatsTests
//
//  Created by Rajesh Rajesh on 09/01/23.
//

import Foundation
@testable import CoronaStats

class MockDetailUseCase: MockBase, GetDetailUseCaseProtocol {
    
    // MARK: - Properties
    var detailData: DetailEntity?
    
    // MARK: - Protocol Function
    
    func fetchCountryDetail(searchText: String, completion: @escaping (CoronaStats.DetailEntity?, Error?) -> ()) {
        if let data = detailData {
            completion(data, nil)
        } else {
            completion(nil, ErrorResult.custom(string: mockErrorMessage))
        }
    }
}
