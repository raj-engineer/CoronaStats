//
//  DetailsViewModel.swift
//  CoronaStats
//
//  Created by Rajesh Rajesh on 08/01/23.
//

final class DetailsViewModel : DetailsViewModelProtocol {
    // MARK: - Properties
    var input: DetailViewModelInput { return self }
    var output: DetailViewModelOutput {return self }
    var loaderStatus: Dynamic<Bool> = Dynamic(false)
    var detailEntity: Dynamic<DetailEntity?> = Dynamic(nil)
    var error: Dynamic<String?> = Dynamic(nil)
    let countryName: String
    
    // MARK: - Private Properties
    private let getDetailUseCase: GetDetailUseCaseProtocol
    
    // MARK: - initializer
    init(with useCase: GetDetailUseCaseProtocol = GetDetailUseCase(), countryName: String) {
        getDetailUseCase = useCase
        self.countryName = countryName
    }
    
    // MARK: - Input function
    func fetchCountryDetail() {
        /// bind data to show Activity indicator
        loaderStatus.value = true
        
        getDetailUseCase.fetchCountryDetail(searchText: countryName) {[weak self] result in
            /// Bind data
            self?.loaderStatus.value = false
            switch result {
            case .success(let detailEntity):
                self?.detailEntity.value = detailEntity
            case .failure(let error):
                self?.error.value = error.localizedDescription
            }
        }
    }
    
    // MARK: - Ouput function
    func getDetailEntity() -> DetailEntity? {
        return detailEntity.value
    }
}
