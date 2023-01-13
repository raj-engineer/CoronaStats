//
//  DetailServiceTest.swift
//  CoronaStatsTests
//
//  Created by Rajesh Rajesh on 13/01/23.
//

import XCTest
@testable import CoronaStats

final class DetailServiceTest: MockBase {
    
    // MARK: - Properties
    var service: DetailService!
    private var mockNetworkService:  MockNetworkService!
    
    // MARK: - setup
    override func setUp() {
        super.setUp()
        mockNetworkService = MockNetworkService()
        service = DetailService(networkService: mockNetworkService)
    }
    
    override func tearDown() {
        service = nil
        mockNetworkService = nil
        super.tearDown()
    }
    
    // MARK: - test functions
    
    /// test  fetchCountries  sucess case
    func testFetchCountryDetailSuccess() {
        // Given
        mockNetworkService.data = mockDetailData
        var detail: Detail?
        
        // When
        service.fetchCountryDetail(searchText: mockCountry) { (result: Result<Detail, Error>) in
            switch result {
            case .success(let _detail):
                detail = _detail
            case .failure(_):
                XCTFail("failure not expected")
            }
        }
        
        // Then
        XCTAssertNotNil(detail)
        XCTAssertEqual(mockDetailData.response?.count, detail?.response?.count)
    }
    
    /// test  fetchCountries  failure case
    func testFetchCountryDetailFailure() {
        // Given
        mockNetworkService.data = nil
        var err: NetworkError?
        
        // When
        service.fetchCountryDetail(searchText: mockCountry) { (result: Result<Detail, Error>) in
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
