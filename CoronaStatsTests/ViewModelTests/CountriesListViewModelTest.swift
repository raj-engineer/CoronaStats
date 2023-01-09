//
//  CountriesListViewModelTest.swift
//  CoronaStatsTests
//
//  Created by Rajesh Rajesh on 09/01/23.
//

import XCTest
@testable import CoronaStats

class CountriesListViewModelTest: XCTestCase {
    
    // MARK: - Properties
    var viewModel: CountriesListViewModel!
    private var mockUseCase:  MockCountriesUseCase!
    let mockCountry = "India"
    
    lazy var mockCountriesData: Countries = {
        let data = mockCountriesJSON.data(using: .utf8)!
        return try! JSONDecoder().decode(Countries.self, from: data)
    }()
    
    lazy var mockEntity: CountriesEntity? = {
        CountriesMapper().getCountriesEntity(responseModel: mockCountriesData)
    }()
    
    // MARK: - setup
    override func setUp() {
        super.setUp()
        self.mockUseCase = MockCountriesUseCase()
        self.viewModel = CountriesListViewModel(getCountriesUseCase: mockUseCase)
    }
    
    override func tearDown() {
        self.viewModel = nil
        self.mockUseCase = nil
        super.tearDown()
    }
    
    // MARK: - test functions
    
    /// test  fetchCountries  sucess case
    func testFetchCountries() {
        // Given
        mockUseCase.countriesData = mockEntity
        
        // When
        self.viewModel.input.fetchCountries()
        
        // Then
        XCTAssertNotNil(self.viewModel.output.getCountriesEntity())
    }
    
    /// test  fetchCountries  failure case
    func testFetchCountriesFail() {
        // Given
        mockUseCase.countriesData = nil
        
        // When
        self.viewModel.input.fetchCountries()
        
        // Then
        XCTAssertNil(self.viewModel.output.getCountriesEntity())
    }
    
    /// test  list item at given index path
    func testGetItem(){
        // Given
        let index0 = IndexPath(row: 0, section: 0)
        mockUseCase.countriesData = mockEntity
        viewModel.input.fetchCountries()
        
        // When
        let countryName = viewModel.output.getItem(at: index0)
        
        // Then
        XCTAssertEqual(countryName, mockCountry)
    }
    
    /// test filter list when user enter text - Ind
    func testFilterCountriesList(){
        // Given
        mockUseCase.countriesData = mockEntity
        viewModel.input.fetchCountries()
        
        // When
        viewModel.input.filterCountriesList(for: "Ind")
        
        // Then
        let count = viewModel.output.getCountriesEntity()?.filteredItems?.count
        XCTAssertEqual(count, 2)
    }
    
    /// test filter list when search text empty
    func testFilterCountriesListWithEmptyText(){
        // Given
        mockUseCase.countriesData = mockEntity
        viewModel.input.fetchCountries()
        
        // When
        viewModel.input.filterCountriesList(for: "")
        
        // Then
        let count = viewModel.output.getCountriesEntity()?.filteredItems?.count
        XCTAssertEqual(count, 3)
    }
}

extension CountriesListViewModelTest {
    var mockCountriesJSON: String {
        return """
        {
          "get": "countries",
          "parameters": [],
          "errors": [],
          "results": 2,
          "response": [
            "India",
            "China",
            "Indonesia"
          ]
        }
        """
    }
}
