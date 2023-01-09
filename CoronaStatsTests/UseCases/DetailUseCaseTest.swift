//
//  DetailUseCaseTest.swift
//  CoronaStatsTests
//
//  Created by Rajesh Rajesh on 09/01/23.
//


import XCTest
@testable import CoronaStats

class DetailUseCaseTest: MockBase {
    
    // MARK: - Properties
    var useCase: GetDetailUseCase!
    private var mockRepository:  MockDetailRepository!
    
    // MARK: - setup
    override func setUp() {
        super.setUp()
        self.mockRepository = MockDetailRepository()
        self.useCase = GetDetailUseCase(repository: mockRepository)
    }
    
    override func tearDown() {
        self.useCase = nil
        self.mockRepository = nil
        super.tearDown()
    }
    
    // MARK: - test functions
    
    /// test  fetchCountries  error case
    func testFetchCountryDetail() {
        // Given
        mockRepository.detailData = nil
        var err : ErrorResult?
        
        // When
        useCase.fetchCountryDetail(searchText: mockCountry) { _, error in
            err = error as? ErrorResult
        }
        
        // Then
        XCTAssertEqual(err?.associatedValue(), mockErrorMessage)
    }
    
    /// test  fetchCountries  sucess case
    func testFetchCountryDetailSucess() {
        // Given
        mockRepository.detailData = mockDetailEntity
        var detailEntity: DetailEntity?
        
        // When
        useCase.fetchCountryDetail(searchText: mockCountry) { _detailEntity, _ in
            detailEntity = _detailEntity
        }
        
        // Then
        XCTAssertEqual(detailEntity?.confirmed, mockDetailEntity.confirmed)
    }
}
