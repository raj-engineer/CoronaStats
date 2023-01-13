//
//  CountriesRepository.swift
//  CoronaStats
//
//  Created by Rajesh Rajesh on 07/01/23.
//

final class CountriesRepository: CountriesRepositoryProtocol {
    // MARK: - Private Properties
    private let service: CountriesServiceProtocol
    
    // MARK: - init
    init(service: CountriesServiceProtocol = CountriesService()) {
        self.service = service
    }
    
    // MARK: - function
    func fetchCountries(completion: @escaping CountriesEntityResponse) {
        service.fetchCountries { (result:Result<Countries, Error>) in
            switch result {
            case .success(let countries):
                let countriesEntity = CountriesMapper().getCountriesEntity(responseModel: countries)
                completion(.success(countriesEntity))
            case .failure(_):
                completion(.failure(NetworkError.failed))
            }
        }
    }
}
