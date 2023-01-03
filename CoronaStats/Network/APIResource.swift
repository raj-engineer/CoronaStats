//
//  APIResource.swift
//  CoronaStats
//
//  Created by Rajesh Rajesh on 02/01/23.
//

import Foundation

// MARK: - APIResource
protocol APIResource {
    associatedtype ModelType: Decodable
    var methodPath: String { get }
    var queryValue: String? { get }
}

extension APIResource {
    var url: URL? {
        var components = URLComponents(string:UrlEnum.baseURL)!
        components.path = methodPath
        
        if let queryValue = queryValue {
            components.queryItems = [URLQueryItem(name: UrlEnum.queryKey, value: queryValue)]
        }
        return components.url
    }
}

// MARK: - CountriesResource
struct CountriesResource: APIResource {
    typealias ModelType = Countries
    var queryValue: String?
    var methodPath: String {
        return UrlEnum.countries
    }
}

// MARK: - DetailResource
struct DetailResource: APIResource {
    typealias ModelType = Detail
    var queryValue: String?
    var methodPath: String {
        return UrlEnum.statistics
    }
}
