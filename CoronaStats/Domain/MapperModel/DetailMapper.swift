//
//  DetailMapper.swift
//  CoronaStats
//
//  Created by Rajesh Rajesh on 08/01/23.
//

import Foundation

protocol DetailMapperProtocol {
    func getDetailEntity(responseModel: Detail?) -> DetailEntity?
}

struct DetailMapper: DetailMapperProtocol {
    
    func getDetailEntity(responseModel: Detail?) -> DetailEntity? {
        guard let object = responseModel?.response?.first else { return nil }
        var mapperModel = DetailEntity()
        if let confirmed = object.cases?.total {
            mapperModel.confirmed = String(confirmed)
        }
        
        if let deceased = object.deaths?.total {
            mapperModel.deceased = String(deceased)
        }
        
        if let recovered = object.cases?.recovered {
            mapperModel.recovered = String(recovered)
        }
        
        return mapperModel
    }
}
