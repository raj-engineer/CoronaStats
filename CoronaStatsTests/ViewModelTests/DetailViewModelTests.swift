//
//  DetailViewModelTests.swift
//  CoronaStatsTests
//
//  Created by Rajesh Rajesh on 05/12/22.
//

import XCTest
@testable import CoronaStats

class DetailViewModelTests: XCTestCase {
    
    // MARK: - Properties
    var viewModel: DetailViewModel!
    private var mockService:  MockDetailService!
    let mockCountry = "India"
    lazy var mockDetailData: Detail = {
        let data = mockDetailJSON.data(using: .utf8)!
        return try! JSONDecoder().decode(Detail.self, from: data)
    }()
    
    // MARK: - setup
    override func setUp() {
        super.setUp()
        self.mockService = MockDetailService()
        self.viewModel = DetailViewModel(withService: mockService, countryName: mockCountry)
    }
    
    override func tearDown() {
        self.viewModel = nil
        self.mockService = nil
        super.tearDown()
    }
    
    // MARK: - test functions
    func testFetchCountryDetail() {
        // Given
        mockService.detailData = mockDetailData
        
        // When
        self.viewModel.fetchCountryDetail()
       
        // Then
        XCTAssertNotNil(self.viewModel.detail.value)
    }
    
    func testFetchCountryDetailFail() {
        // Given
        mockService.detailData = nil
        self.viewModel = DetailViewModel(countryName: "")
       
        // When
        self.viewModel.fetchCountryDetail()
        
        // Then
        XCTAssertNil(self.viewModel.detail.value)
    }
    
    func testGetCountryDetail() {
        // Given
        mockService.detailData = mockDetailData
        self.viewModel.fetchCountryDetail()
      
        // When
        let model = self.viewModel.getCountryDetail()
        
        // Then
        XCTAssertNotNil(model)
        XCTAssertEqual(model?.confirmed, "44674667")
        XCTAssertEqual(model?.recovered, "44138554")
        XCTAssertEqual(model?.deceased, "530630")
    }
 
}

extension DetailViewModelTests {
    var mockDetailJSON: String {
        return """
        {
          "get": "statistics",
          "parameters": {
            "country": "India"
          },
          "errors": [],
          "results": 1,
          "response": [
            {
              "continent": "Asia",
              "country": "India",
              "population": 1406631776,
              "cases": {
                "new": null,
                "active": 5483,
                "critical": 698,
                "recovered": 44138554,
                "1M_pop": "31760",
                "total": 44674667
              },
              "deaths": {
                "new": null,
                "1M_pop": "377",
                "total": 530630
              },
              "tests": {
                "1M_pop": "645065",
                "total": 907369299
              },
              "day": "2022-12-05",
              "time": "2022-12-05T06:00:09+00:00"
            }
          ]
        }
        """
    }
}
