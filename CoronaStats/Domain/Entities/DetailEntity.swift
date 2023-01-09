//
//  DetailEntity.swift
//  CoronaStats
//
//  Created by Rajesh Rajesh on 08/01/23.
//

import Foundation

// MARK: - struct
struct DetailEntity {
    
    // MARK: - Properties
    var confirmed: String?
    var deceased: String?
    var recovered: String?
    
    // MARK: - init
    init(confirmed: String? = nil, deceased: String? = nil, recovered: String? = nil) {
        self.confirmed = confirmed
        self.deceased = deceased
        self.recovered = recovered
    }
}
