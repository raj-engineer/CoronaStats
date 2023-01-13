//
//  MockBase.swift
//  CoronaStatsTests
//
//  Created by Rajesh Rajesh on 09/01/23.
//

import XCTest
@testable import CoronaStats

class MockBase: XCTestCase {
    
    let mockCountry = "India"
    let mockErrorMessage = "mock Error"
    
    lazy var mockCountriesData: Countries = {
        let data = mockCountriesJSON.data(using: .utf8)!
        return try! JSONDecoder().decode(Countries.self, from: data)
    }()
    
    lazy var mockDetailData: Detail = {
        let data = mockCountriesDetailJSON.data(using: .utf8)!
        return try! JSONDecoder().decode(Detail.self, from: data)
    }()
    
    lazy var mockEntity: CountriesEntity? = {
        CountriesMapper().getCountriesEntity(responseModel: mockCountriesData)
    }()
    
    lazy var mockDetailEntity: DetailEntity = {
        DetailMapper().getDetailEntity(responseModel: mockDetailData)
    }()
    
    var mockCountriesJSON: String {
        return """
        {
          "get": "countries",
          "parameters": [],
          "errors": [],
          "results": 3,
          "response": [
            "India",
            "China",
            "Indonesia"
          ]
        }
        """
    }
    
    var mockCountriesDetailJSON: String {
        return """
        {
          "get": "statistics",
          "parameters": [],
          "errors": [],
          "results": 2,
          "response":
        [
             {
                  "cases": {
                    "1M_pop": "150",
                    "active": 101069,
                    "critical": 8944,
                    "new": "+8813",
                    "recovered": 100285,
                    "total": 207183
                  },
                  "continent": "Asia",
                  "country": "India",
                  "day": "2020-06-02",
                  "deaths": {
                    "1M_pop": "4",
                    "new": "+221",
                    "total": 5829
                  },
                  "population": 1378900337,
                  "tests": {
                    "1M_pop": "2876",
                    "total": 3966075
                  },
                  "time": "2020-06-02T20:45:06+00:00"
                }
          ]
        }
        """
    }
}
