//
//  DetailsViewModel.swift
//  CoronaStats
//
//  Created by Rajesh Rajesh on 08/01/23.
//

import Foundation

class DetailsViewModel : DetailsViewModelProtocol {
    // MARK: - Properties
    var input: DetailViewModelInput { return self }
    var output: DetailViewModelOutput {return self }
    var loaderStatus: Dynamic<Bool> = Dynamic(false)
    var detailEntity: Dynamic<DetailEntity?> = Dynamic(nil)
    let countryName: String
    
    // MARK: - Private Properties
    private let getDetailUseCase: GetDetailUseCaseProtocol
    
    // MARK: - initializer
    init(with useCase: GetDetailUseCaseProtocol, countryName: String) {
        self.getDetailUseCase = useCase
        self.countryName = countryName
    }
    
    convenience init(countryName: String) {
        let repository = DetailRepository(dataSource: DetailDataSource())
        let useCase = GetDetailUseCase(repository: repository)
        self.init(with: useCase, countryName: countryName)
    }
    
    // MARK: - Input function
    func fetchCountryDetail() {
        /// bind data to show Activity indicator
        loaderStatus.value = true
        self.getDetailUseCase.fetchCountryDetail(searchText: countryName) {[weak self] (detailEntity, err) in
            /// Bind data
            self?.detailEntity.value = detailEntity
            self?.loaderStatus.value = false  /// to hide Activity indicator
        }
    }
    
    // MARK: - Ouput function
    func getCountryDetail() -> DetailEntity? {
        return detailEntity.value
    }
}
