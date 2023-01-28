//
//  CountriesRepositoryTest.swift
//  CoronaStatsTests
//
//  Created by Rajesh Rajesh on 13/01/23.
//

import XCTest
@testable import CoronaStats

final class CountriesRepositoryTest: MockBase {
    
    // MARK: - Properties
    var repository: CountriesRepositoryProtocol!
    private var mockService:  MockCountriesService!
    
    // MARK: - setup
    override func setUp() {
        super.setUp()
        mockService = MockCountriesService()
        repository = CountriesRepository(service: mockService)
    }
    
    override func tearDown() {
        repository = nil
        mockService = nil
        super.tearDown()
    }
    
    // MARK: - test functions
    
    /// test  fetchCountries  sucess case
    func testFetchCountriesSuccess() {
        // Given
        mockService.data = mockCountriesData
        var countries: CountriesEntity?
        
        // When
        repository.fetchCountries { (result: Result<CountriesEntity, Error>) in
            switch result {
            case .success(let countriesEntity):
                countries = countriesEntity
            case .failure(_):
                XCTFail("failure not expected")
            }
        }
        
        // Then
        XCTAssertEqual(countries?.response.count, mockEntity?.response.count)
    }
    
    /// test  fetchCountries  failure case
    func testFetchCountriesFailure() {
        // Given
        mockService.data = nil
        var err : NetworkError?
        
        // When
        repository.fetchCountries { (result: Result<CountriesEntity, Error>) in
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
