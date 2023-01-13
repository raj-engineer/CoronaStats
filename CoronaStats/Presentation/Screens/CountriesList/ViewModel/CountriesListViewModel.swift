//
//  CountriesListViewModel.swift
//  CoronaStats
//
//  Created by Rajesh Rajesh on 08/01/23.
//

import Foundation

final class CountriesListViewModel: CountriesListViewModelProtocol {
    
    // MARK: - Properties
    var input: CountriesListViewModelInput { return self }
    var output: CountriesListViewModelOutput {return self }
    var loaderStatus: Dynamic<Bool> = Dynamic(false)
    var reloadTable: Dynamic<Bool> = Dynamic(false)
    var error: Dynamic<String?> = Dynamic(nil)
    
    // MARK: - Private Properties
    private let getCountriesUseCase: GetCountriesUseCaseProtocol
    private var countriesEntity: CountriesEntity = CountriesEntity()
    
    // MARK: - init
    init(with getCountriesUseCase: GetCountriesUseCaseProtocol = GetCountriesUseCase()) {
        self.getCountriesUseCase = getCountriesUseCase
    }
    
    // MARK: - Input function
    func fetchCountries() {
        /// bind data to show Activity indicator
        loaderStatus.value = true
        getCountriesUseCase.fetchCountries { [weak self] result in
            self?.loaderStatus.value = false
            switch result {
            case .success(let countriesEntity):
                if !(countriesEntity.response.isEmpty == true) {
                    self?.countriesEntity = countriesEntity
                    self?.setFilteredList(items: countriesEntity.response)
                    self?.reloadTable.value = true
                } else {
                    self?.error.value = Errors.NoData.rawValue
                }
            case .failure(let error):
                self?.error.value = error.localizedDescription
            }
        }
    }
    
    private func setFilteredList(items: [String]){
        self.countriesEntity.filteredItems = items
    }
    
    // MARK: - Ouput function
    func numberOfSection() -> Int {
        return countriesEntity.filteredItems.count
    }
    
    func getItem(at indexPath: IndexPath) -> String {
        guard !(countriesEntity.filteredItems.isEmpty) else { return "" }
        let countryName = countriesEntity.filteredItems[indexPath.row]
        return countryName
    }
    
    func filterCountriesList(for searchText: String) {
        // If we haven't typed anything into the search bar then do not filter the results
       // guard let countries = countriesEntity.response else { return }
        let countries = countriesEntity.response
        if searchText == "" {
            setFilteredList(items: countries)
        } else {
            // Filter the results
            let filterCountries = countries.filter { $0.lowercased().contains(searchText.lowercased()) }
            setFilteredList(items: filterCountries)
        }
        
        /// reload tableView
        self.reloadTable.value = true
    }
    
    func getCountriesEntity() -> CountriesEntity {
        return countriesEntity
    }
}
