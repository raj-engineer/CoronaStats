//
//  DetailsViewModelTest.swift
//  CoronaStatsTests
//
//  Created by Rajesh Rajesh on 09/01/23.
//


import XCTest
@testable import CoronaStats

class DetailViewModelTest: MockBase {
    
    // MARK: - Properties
    var viewModel: DetailsViewModel!
    private var mockUseCase:  MockDetailUseCase!
    
    // MARK: - setup
    override func setUp() {
        super.setUp()
        self.mockUseCase = MockDetailUseCase()
        self.viewModel = DetailsViewModel(with: mockUseCase, countryName: mockCountry)
    }
    
    override func tearDown() {
        self.viewModel = nil
        self.mockUseCase = nil
        super.tearDown()
    }
    
    // MARK: - test functions
    /// test  fetchCountryDetail  sucess case
    func testFetchCountryDetail() {
        // Given
        mockUseCase.detailData = mockDetailEntity
        
        // When
        self.viewModel.input.fetchCountryDetail()
        
        // Then
        XCTAssertNotNil(self.viewModel.output.getDetailEntity())
    }
    
    /// test  fetchCountryDetail  failure case
    func testFetchCountryDetailFail() {
        // Given
        mockUseCase.detailData = nil
        self.viewModel = DetailsViewModel(countryName: "")
        
        // When
        self.viewModel.fetchCountryDetail()
        
        // Then
        XCTAssertNil(self.viewModel.output.getDetailEntity())
    }
    
    /// test  getDetailEntity  sucess case if have data
    func testGetDetailEntity() {
        // Given
        mockUseCase.detailData = mockDetailEntity
        self.viewModel.fetchCountryDetail()
        
        // When
        let model = self.viewModel.getDetailEntity()
        
        // Then
        XCTAssertNotNil(model)
        XCTAssertEqual(model?.confirmed, mockDetailEntity.confirmed)
        XCTAssertEqual(model?.recovered, mockDetailEntity.recovered)
        XCTAssertEqual(model?.deceased, mockDetailEntity.deceased)
    }
    
    /// test  getDetailEntity  fail case if no data
    func testGetDetailEntityWithNil() {
        // Given - By default- nil
        
        // When
        let model = self.viewModel.output.getDetailEntity()
        
        // Then
        XCTAssertNil(model)
    }
}
