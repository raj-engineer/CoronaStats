//
//  NwtworkRequest.swift
//  CoronaStats
//
//  Created by Rajesh Rajesh on 02/01/23.
//

import Foundation
import UIKit

// MARK: - Protocol
protocol NetworkRequest: AnyObject {
    associatedtype ModelType
    func decode(_ data: Data) -> ModelType?
    func execute(withCompletion completion: @escaping (ModelType?,Error?) -> Void)
}

// MARK: - Extension
extension NetworkRequest {
    
    // MARK: - function
    func load(_ url: URL, withCompletion completion: @escaping (ModelType?,Error?) -> Void) {
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = keys.rapidHeaders
        let task = URLSession.shared.dataTask(with: request) { [weak self] (data, _ , err) -> Void in
            guard let data = data, let value = self?.decode(data) else {
                DispatchQueue.main.async { completion(nil,err) }
                return
            }
            
            DispatchQueue.main.async { completion(value,nil) }
        }
        task.resume()
    }
}
