//
//  CountriesViewModel.swift
//  CoronaStats
//
//  Created by Rajesh Rajesh on 03/12/22.
//

import Foundation
import UIKit
class CountriesViewModel: CountriesViewModelProtocol {
    
    // MARK: - Protocol Properties
    var selectedData: String?
    var countries: Dynamic<[String]?> = Dynamic(nil)
    var error: Dynamic<String?> = Dynamic(nil)
    var filteredItems: [String]?
    
    // MARK: - Properties
    private var countriesService: CountriesServiceProtocol?
    
    // MARK: - initializer
    init(withService service: CountriesServiceProtocol) {
        // perform initialization
        self.countriesService = service
    }
    
    // MARK: - Protocol function
    func fetchCountries() {
        guard let service = countriesService else { return }
        
        /// show Activity indicator
        Loader.shared.showLoadingView(true)
        
        /// fetch Countries from server
        service.fetchCountries() { [weak self] (data, err) in
            /// hide Activity indicator
            Loader.shared.showLoadingView(false)
            
            /// Bind data
            if let _data = data, !(_data.response?.isEmpty == true) {
                self?.countries.value = _data.response
                self?.filteredItems = _data.response
            } else {
                self?.error.value = err?.localizedDescription ?? Errors.NoData.rawValue
            }
        }
    }
    
    func didSelectItemAt(indexPath: IndexPath) {
        guard let countryName = filteredItems?[indexPath.row] else { return }
        selectedData = countryName
    }
}
