//
//  MockDetailUseCase.swift
//  CoronaStatsTests
//
//  Created by Rajesh Rajesh on 09/01/23.
//

@testable import CoronaStats

final class MockDetailUseCase: MockBase, GetDetailUseCaseProtocol {
    
    // MARK: - Properties
    var detailData: DetailEntity?
    
    // MARK: - Protocol Function
    
    func fetchCountryDetail(searchText: String, completion: @escaping CoronaStats.DetailEntityResponse) {
        if let data = detailData {
            completion(.success(data))
        } else {
            completion(.failure(ErrorResult.custom(string: mockErrorMessage)))
        }
    }
}
