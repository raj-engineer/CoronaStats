//
//  NeworkRequest.swift
//  CoronaStats
//
//  Created by Rajesh Rajesh on 11/01/23.
//
// URLRequestGenerator
import Foundation

protocol NeworkRequestProtocol {
    func createURLRequest(with networkConfig: NetworkConfigurable) throws -> URLRequest
}

final class NeworkRequest: NeworkRequestProtocol {
        
    func createURLRequest(with networkConfig: NetworkConfigurable) throws -> URLRequest {
        do {
            let url = try createURL(with: networkConfig)
            
            var urlRequest = URLRequest(url: url,
                                        cachePolicy: .useProtocolCachePolicy,
                                        timeoutInterval: 10.0)
    
            urlRequest.httpMethod = networkConfig.method.rawValue
            urlRequest.allHTTPHeaderFields = keys.rapidHeaders
            if !networkConfig.bodyParamaters.isEmpty {
                let bodyData = try? JSONSerialization.data(withJSONObject: networkConfig.bodyParamaters, options: [.prettyPrinted])
                urlRequest.httpBody = bodyData
            }
            
            networkConfig.headerParamaters.forEach({ key, value in
                urlRequest.setValue(value, forHTTPHeaderField: key)
            })
            
            return urlRequest
        } catch {
            throw error
        }
    }
    
    private func createURL(with networkConfig: NetworkConfigurable) throws -> URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = UrlEnum.host
        components.path = networkConfig.path
        components.queryItems = networkConfig.queryParameters.map {
            URLQueryItem(name: $0, value: "\($1)")
        }
        
        guard let url = components.url else {
            throw NSError(domain: "URL", code: NSURLErrorBadURL, userInfo: nil)
        }
        return url
    }
}
