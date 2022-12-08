//
//  Constants.swift
//  CoronaStats
//
//  Created by Rajesh Rajesh on 03/12/22.
//

import Foundation

// MARK: - Url
enum UrlEnum {
    static let baseUrl = "https://covid-193.p.rapidapi.com/"
    static let countryUrl = baseUrl+"countries"
    static let detailUrl = baseUrl+"statistics?country="
}

// MARK: - Api Key
enum keys {
    static let rapidHeaders = [
        "x-rapidapi-host": "covid-193.p.rapidapi.com",
        "x-rapidapi-key": "yUDMsYUkOtmshDZad5laozt4Hx3Wp11A5GHjsnJHCJTFMWmnGn"
    ]
}

// MARK: - Error 
enum Errors: String {
    case NOInternetConnection = "NO Internet Connection , Try Again"
    case NoData = "Data Not Available"
}

enum ErrorResult: Error {
    case custom(string: String)
}

enum ScreenTitle {
    static let Countries = "Countries"
}
