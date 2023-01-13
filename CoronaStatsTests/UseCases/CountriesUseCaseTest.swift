//
//  CountriesUseCaseTest.swift
//  CoronaStatsTests
//
//  Created by Rajesh Rajesh on 09/01/23.
//
import XCTest
@testable import CoronaStats

final class CountriesUseCaseTest: MockBase {
    
    // MARK: - Properties
    var useCase: GetCountriesUseCase!
    private var mockRepository:  MockCountriesRepository!
    
    // MARK: - setup
    override func setUp() {
        super.setUp()
        mockRepository = MockCountriesRepository()
        useCase = GetCountriesUseCase(repository: mockRepository)
    }
    
    override func tearDown() {
        useCase = nil
        mockRepository = nil
        super.tearDown()
    }
    
    // MARK: - test functions
    
    /// test  fetchCountries  failure case
    func testFetchCountries() {
        // Given
        mockRepository.countriesData = nil
        var err : ErrorResult?
        
        // When
        useCase.fetchCountries { (result: Result<CountriesEntity, Error>) in
            switch result {
            case .success(_):
                XCTFail("Success not expected")
            case .failure(let error):
               err = error as? ErrorResult
            }
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
        useCase.fetchCountries { (result: Result<CountriesEntity, Error>) in
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
}
