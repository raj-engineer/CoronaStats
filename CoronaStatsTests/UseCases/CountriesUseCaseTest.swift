//
//  CountriesUseCaseTest.swift
//  CoronaStatsTests
//
//  Created by Rajesh Rajesh on 09/01/23.
//
import XCTest
@testable import CoronaStats

class CountriesUseCaseTest: MockBase {
    
    // MARK: - Properties
    var useCase: GetCountriesUseCase!
    private var mockRepository:  MockCountriesRepository!
    
    // MARK: - setup
    override func setUp() {
        super.setUp()
        self.mockRepository = MockCountriesRepository()
        self.useCase = GetCountriesUseCase(repository: mockRepository)
    }
    
    override func tearDown() {
        self.useCase = nil
        self.mockRepository = nil
        super.tearDown()
    }
    
    // MARK: - test functions
    
    /// test  fetchCountries  failure case
    func testFetchCountries() {
        // Given
        mockRepository.countriesData = nil
        var err : ErrorResult?
        
        // When
        useCase.fetchCountries {( _, error) in
            err = error as? ErrorResult
        }
        
        // Then
        XCTAssertEqual(err?.associatedValue(), mockErrorMessage)
    }
    
    /// test  fetchCountries  sucess case
    func testFetchCountriesSucess() {
        // Given
        mockRepository.countriesData = mockEntity
        var countries: CountriesEntity?
        
        // When
        useCase.fetchCountries { (countriesEntity, _) in
            countries = countriesEntity
        }
        
        // Then
        XCTAssertEqual(countries?.response?.count, mockEntity?.response?.count)
    }
}
