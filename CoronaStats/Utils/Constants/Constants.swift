//
//  Constants.swift
//  CoronaStats
//
//  Created by Rajesh Rajesh on 03/12/22.
//

import Foundation

// MARK: - Url
enum UrlEnum {
    // Host
    static let baseURL = "https://covid-193.p.rapidapi.com"
    // path
    static let statistics = "/statistics"
    static let countries = "/countries"
    // Optional- Query Component Key
    static let queryKey = "country"
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
    case InvalidUrl = "Url Not Valid"
}

enum ErrorResult: Error {
    case custom(string: String)
}

enum ScreenTitle {
    static let Countries = "Countries"
}
