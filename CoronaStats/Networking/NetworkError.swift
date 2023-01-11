//
//  NetworkError.swift
//  CoronaStats
//
//  Created by Rajesh Rajesh on 11/01/23.
//

import Foundation

enum NetworkError: Error {
    case invalidRequest
    case badRequest
    case failed
    case noData
    case noResponse
    case unableToDecode
    
    var description: String {
        
        switch self {
        case .invalidRequest: return "Invalid Request"
        case .badRequest: return "Bad Request"
        case .failed: return "Network Request Failed"
        case .noData: return "Data Not Available"
        case .noResponse: return "Response returned with no response"
        case .unableToDecode: return "Response couldnot be decoded"
        }
    }
}
