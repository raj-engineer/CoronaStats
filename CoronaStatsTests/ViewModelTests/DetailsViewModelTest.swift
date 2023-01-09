//
//  DetailsViewModelTest.swift
//  CoronaStatsTests
//
//  Created by Rajesh Rajesh on 09/01/23.
//


import XCTest
@testable import CoronaStats

class DetailViewModelTest: XCTestCase {
    
    // MARK: - Properties
    var viewModel: DetailsViewModel!
    private var mockUseCase:  MockDetailUseCase!
    let mockCountry = "India"
    
    lazy var mockDetailEntity: DetailEntity = {
        DetailEntity(confirmed: "44674667", deceased: "530630", recovered: "44138554")
    }()
    
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
        XCTAssertNotNil(self.viewModel.output.getCountryDetail())
    }
    
    /// test  fetchCountryDetail  failure case
    func testFetchCountryDetailFail() {
        // Given
        mockUseCase.detailData = nil
        self.viewModel = DetailsViewModel(countryName: "")
        
        // When
        self.viewModel.fetchCountryDetail()
        
        // Then
        XCTAssertNil(self.viewModel.getCountryDetail())
    }
    
    /// test  getCountryDetail  sucess case if have data
    func testGetCountryDetail() {
        // Given
        mockUseCase.detailData = mockDetailEntity
        self.viewModel.fetchCountryDetail()
        
        // When
        let model = self.viewModel.getCountryDetail()
        
        // Then
        XCTAssertNotNil(model)
        XCTAssertEqual(model?.confirmed, "44674667")
        XCTAssertEqual(model?.recovered, "44138554")
        XCTAssertEqual(model?.deceased, "530630")
    }
    
    /// test  getCountryDetail  fail case if no data
    func testGetCountryDetailWithNil() {
        // Given - By default- nil
        
        // When
        let model = self.viewModel.getCountryDetail()
        
        // Then
        XCTAssertNil(model)
    }
}
