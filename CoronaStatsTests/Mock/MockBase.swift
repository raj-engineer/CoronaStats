//
//  MockBase.swift
//  CoronaStatsTests
//
//  Created by Rajesh Rajesh on 09/01/23.
//

import Foundation
import XCTest
@testable import CoronaStats

class MockBase: XCTestCase {
    
    let mockCountry = "India"
    let mockErrorMessage = "mock Error"
    
    
    lazy var mockCountriesData: Countries = {
        let data = mockCountriesJSON.data(using: .utf8)!
        return try! JSONDecoder().decode(Countries.self, from: data)
    }()
    
    lazy var mockEntity: CountriesEntity? = {
        CountriesMapper().getCountriesEntity(responseModel: mockCountriesData)
    }()
   
    lazy var mockDetailEntity: DetailEntity = {
        DetailEntity(confirmed: "44674667", deceased: "530630", recovered: "44138554")
    }()
    
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
