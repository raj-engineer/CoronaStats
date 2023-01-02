//
//  Service.swift
//  CoronaStats
//
//  Created by Rajesh Rajesh on 03/12/22.
//

import Foundation
final class ApiService {

   public func fetchGenericJSONData<T: Decodable>(urlString: String, completion: @escaping (T?, Error?) -> ()) {
        guard let url = URL(string: urlString) else { return }
       var request = URLRequest(url: url)
       request.allHTTPHeaderFields = keys.rapidHeaders
        URLSession.shared.dataTask(with: request) { (data, resp, err) in
            if let err = err {
                completion(nil, err)
                return
            }
            do {
                let objects = try JSONDecoder().decode(T.self, from: data!)
                // success
                completion(objects, nil)
            } catch {
                completion(nil, error)
            }
        }.resume()
    }
    
}
