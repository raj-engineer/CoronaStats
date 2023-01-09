//
//  CountriesListViewModel.swift
//  CoronaStats
//
//  Created by Rajesh Rajesh on 08/01/23.
//

import Foundation

class CountriesListViewModel:NSObject, CountriesListViewModelProtocol {
    
    // MARK: - Properties
    var input: CountriesListViewModelInput { return self }
    var output: CountriesListViewModelOutput {return self }
    var loaderStatus: Dynamic<Bool> = Dynamic(false)
    var reloadTable: Dynamic<Bool> = Dynamic(false)
    var error: Dynamic<String?> = Dynamic(nil)
    
    // MARK: - Private Properties
    private let getCountriesUseCase: GetCountriesUseCaseProtocol
    private var countriesEntity: CountriesEntity?
    
    // MARK: - init
    override init() {
        let repository = CountriesRepository(dataSource: CountriesDataSource())
        let useCase =  GetCountriesUseCase(repository: repository)
        self.getCountriesUseCase = useCase
    }
    
    init(getCountriesUseCase: GetCountriesUseCaseProtocol) {
        self.getCountriesUseCase = getCountriesUseCase
    }
    
    // MARK: - Input function
    func fetchCountries() {
        /// bind data to show Activity indicator
        loaderStatus.value = true
        
        self.getCountriesUseCase.fetchCountries {[weak self] (countriesEntity, err) in
            /// Bind data
            self?.loaderStatus.value = false  /// to hide Activity indicator
            if let _countriesEntity = countriesEntity, !(_countriesEntity.response?.isEmpty == true) {
                self?.reloadTable.value = true
                self?.countriesEntity = _countriesEntity
                self?.setFilteredList(items: _countriesEntity.response)
            } else {
                self?.error.value = err?.localizedDescription ?? Errors.NoData.rawValue
            }
        }
    }
    
    private func setFilteredList(items: [String]?){
        self.countriesEntity?.filteredItems = items
    }
    
    // MARK: - Ouput function
    func numberOfSection() -> Int {
        return  self.countriesEntity?.filteredItems?.count ?? 0
    }
    
    func getItem(at indexPath: IndexPath) -> String? {
        let countryName = self.countriesEntity?.filteredItems?[indexPath.row]
        return countryName
    }
    
    func filterCountriesList(for searchText: String) {
        // If we haven't typed anything into the search bar then do not filter the results
        guard let countries = countriesEntity?.response else { return }
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
    
    func getCountriesEntity() -> CountriesEntity? {
        return countriesEntity
    }
}
