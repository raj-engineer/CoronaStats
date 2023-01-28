//
//  DetailRepositoryTest.swift
//  CoronaStatsTests
//
//  Created by Rajesh Rajesh on 13/01/23.
//

import XCTest
@testable import CoronaStats

final class DetailRepositoryTest: MockBase {
    
    // MARK: - Properties
    var repository: DetailRepositoryProtocol!
    private var mockService:  MockDetailService!
    
    // MARK: - setup
    override func setUp() {
        super.setUp()
        mockService = MockDetailService()
        repository = DetailRepository(service: mockService)
    }
    
    override func tearDown() {
        repository = nil
        mockService = nil
        super.tearDown()
    }
    
    // MARK: - test functions
    
    /// test  fetchCountries  sucess case
    func testFetchCountryDetailSuccess() {
        // Given
        mockService.data = mockDetailData
        var detail: DetailEntity?
        
        // When
        repository.fetchCountryDetail(searchText: mockCountry) { (result: Result<DetailEntity, Error>) in
            switch result {
            case .success(let detailEntity):
                detail = detailEntity
            case .failure(_):
                XCTFail("failure not expected")
            }
        }
        
        // Then
        XCTAssertEqual(detail?.confirmed, mockDetailEntity.confirmed)
    }
    
    /// test  fetchCountries  failure case
    func testFetchCountryDetailFailure() {
        // Given
        mockService.data = nil
        var err: NetworkError?
        
        // When
        repository.fetchCountryDetail(searchText: mockCountry) { (result: Result<DetailEntity, Error>) in
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
