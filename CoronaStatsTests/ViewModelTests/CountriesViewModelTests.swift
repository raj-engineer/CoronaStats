//
//  CountriesViewModelTests.swift
//  CoronaStatsTests
//
//  Created by Rajesh Rajesh on 05/12/22.
//

import XCTest
@testable import CoronaStats

class CountriesViewModelTests: XCTestCase {
    
    // MARK: - Properties
    var viewModel: CountriesViewModel!
    private var mockService:  MockCountriesService!
    
    lazy var mockCountriesData: Countries = {
        let data = mockCountriesJSON.data(using: .utf8)!
        return try! JSONDecoder().decode(Countries.self, from: data)
    }()
    
    // MARK: - setup
    override func setUp() {
        super.setUp()
        self.mockService = MockCountriesService()
        self.viewModel = CountriesViewModel(withService: mockService)
    }
    
    override func tearDown() {
        self.viewModel = nil
        self.mockService = nil
        super.tearDown()
    }
    
    // MARK: - test functions
    func testFetchCountries() {
        // Given
        mockService.countriesData = mockCountriesData
        
        // When
        self.viewModel.fetchCountries()
        
        // Then
        XCTAssertNotNil(self.viewModel.countries.value)
    }
    
    func testFetchCountriesFail() {
        // Given
        mockService.countriesData = nil
        
        // When
        self.viewModel.fetchCountries()
        
        // Then
        XCTAssertNil(self.viewModel.countries.value)
    }
    
    func testDidSelectItemAt() {
        // Given
        mockService.countriesData = mockCountriesData
        self.viewModel.fetchCountries()
        let index0 = IndexPath(row: 0, section: 0)
        
        // When
        self.viewModel.didSelectItemAt(indexPath: index0)
        
        // Then
        XCTAssertEqual(self.viewModel.selectedData, "India")
    }
}

extension CountriesViewModelTests {
    var mockCountriesJSON: String {
        return """
        {
          "get": "countries",
          "parameters": [],
          "errors": [],
          "results": 2,
          "response": [
            "India",
            "China"
          ]
        }
        """
    }
}
