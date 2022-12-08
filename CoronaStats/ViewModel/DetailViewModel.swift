//
//  detailViewModel.swift
//  CoronaStats
//
//  Created by Rajesh Rajesh on 04/12/22.
//

import Foundation

struct DetailViewModelMapper {
    var confirmed: String?
    var deceased: String?
    var recovered: String?
    
    init(confirmed: String? = nil, deceased: String? = nil, recovered: String? = nil) {
            self.confirmed = confirmed
            self.deceased = deceased
            self.recovered = recovered
        }
}

class DetailViewModel: DetailViewModelProtocol {
 
    // MARK: - Protocol Properties
    let countryName: String
    var detail: Dynamic<[Response]?>  = Dynamic(nil)
   
    // MARK: -  Properties
    private var detailService: DetailServiceProtocol?
   
    // MARK: - initializer
    init(withService service: DetailServiceProtocol, countryName: String) {
        self.detailService = service
        self.countryName = countryName
    }
    
    convenience init(countryName: String) {
        self.init(withService: DetailService(), countryName: countryName)
    }
    
    // MARK: - Protocol function
    func fetchCountryDetail() {
        guard let service = detailService else { return }
        Loader.shared.showLoadingView(true)
        service.fetchCountryDetail(searchText: countryName) { [weak self] (data, err) in
            self?.detail.value = data?.response
            Loader.shared.showLoadingView(false)
        }
    }
    
    func getCountryDetail() -> DetailViewModelMapper? {
        guard let object = detail.value?.first else { return nil }
        var mapperModel = DetailViewModelMapper()
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

