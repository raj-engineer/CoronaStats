//
//  APIRequest.swift
//  CoronaStats
//
//  Created by Rajesh Rajesh on 03/01/23.
//

import Foundation

// MARK: - Class APIRequest
class APIRequest<Resource: APIResource> {
    let resource: Resource
    
    init(resource: Resource) {
        self.resource = resource
    }
}

// MARK: - Extension APIRequest
extension APIRequest: NetworkRequest {
    
    // MARK: - function
    func decode(_ data: Data) -> Resource.ModelType? {
        do {
            let modelType = try JSONDecoder().decode(Resource.ModelType.self, from: data)
            // success
            return modelType
        } catch {
            return nil
        }
    }
    
    func execute(withCompletion completion: @escaping (Resource.ModelType?, Error?) -> Void) {
        guard let url = resource.url else {
            DispatchQueue.main.async { completion(nil,ErrorResult.custom(string: Errors.InvalidUrl.rawValue)) }
            return
        }
        
        load(url, withCompletion: completion)
    }
}
