//
//  MockNetworkService.swift
//  CoronaStatsTests
//
//  Created by Rajesh Rajesh on 13/01/23.
//

@testable import CoronaStats

final class MockNetworkService: MockBase,NetworkServiceProtocol {
    
    // MARK: - Properties
    var data: Decodable?
    
    // MARK: - Protocol Function
    func execute<T>(networkConfig: NetworkConfigurable, completion: @escaping CompletionHandler<T>) where T : Decodable {
        if let _data = data {
            completion(.success(_data as! T))
        } else {
            completion(.failure(NetworkError.failed))
        }
    }
}
