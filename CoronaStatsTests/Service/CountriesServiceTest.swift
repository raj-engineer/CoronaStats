//
//  CountriesServiceTest.swift
//  CoronaStatsTests
//
//  Created by Rajesh Rajesh on 13/01/23.
//

import XCTest
@testable import CoronaStats

final class CountriesServiceTest: MockBase {
    
    // MARK: - Properties
    var service: CountriesServiceProtocol!
    private var mockNetworkService:  MockNetworkService!
    
    // MARK: - setup
    override func setUp() {
        super.setUp()
        mockNetworkService = MockNetworkService()
        service = CountriesService(networkService: mockNetworkService)
    }
    
    override func tearDown() {
        service = nil
        mockNetworkService = nil
        super.tearDown()
    }
    
    // MARK: - test functions
    
    /// test  fetchCountries  sucess case
    func testFetchCountriesSuccess() {
        // Given
        mockNetworkService.data = mockCountriesData
        var countries: Countries?
        
        // When
        service.fetchCountries { (result: Result<Countries, Error>) in
            switch result {
            case .success(let _countries):
                countries = _countries
            case .failure(_):
                XCTFail("failure not expected")
            }
        }
        
        // Then
        XCTAssertNotNil(countries)
        XCTAssertEqual(mockCountriesData.response?.count, countries?.response?.count)
    }
    
    /// test  fetchCountries  failure case
    func testFetchCountriesFailure() {
        // Given
        mockNetworkService.data = nil
        var err: NetworkError?
        
        // When
        service.fetchCountries { (result: Result<Countries, Error>) in
            switch result {
            case .success(_):
                XCTFail("Success not expected")
            case .failure(let error):
                err = error as? NetworkError
            }
        }
        
        // Then
        XCTAssertEqual(err?.description, NetworkError.failed.description)
    }
}
